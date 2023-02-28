import 'package:diaryapp/pages/add_edit_page.dart';
import 'package:diaryapp/pages/details_page.dart';
import 'package:diaryapp/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    super.initState();
    // getTodo();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text("My Diary",
                style: TextStyle(
                    fontFamily: "Mynerve",
                    fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                },
                child: const Icon(Icons.person_rounded,color: Colors.white),

              ),
            ]
        ),
        body: Container(
          height: 900,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: RefreshIndicator(
              onRefresh: fetchTodo,
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index] as Map;
                  final id = items[index]['_id'] as String;
                  return
                    Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                        decoration: const BoxDecoration(
                            color: Colors.cyanAccent),
                        child: Column(
                            children: [
                              const SizedBox(height: 25.0),
                              ListTile(
                                leading: CircleAvatar(
                                    backgroundColor:
                                    index % 2 == 0 ? Colors.black87 : Colors.black,
                                    foregroundColor: Colors.cyan,
                                    child: Text('${index + 1}',
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontFamily: "Mynerve",
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white))),
                                title: Text(items[index]['title'],
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontFamily: "Mynerve",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54)),

                                //subtitle: Text(items[index]['description']),
                                trailing: PopupMenuButton(
                                  onSelected: (value) {
                                    if(value == 'edit'){
                                      navigateToEditTodo(item);
                                    } else if(value == 'delete'){
                                      showMyDialog(context, id, index);
                                    }
                                  },
                                  itemBuilder: (context) {
                                    return [
                                      const PopupMenuItem(
                                        value: 'edit',
                                        child: Icon(
                                          Icons.edit_rounded,
                                          color: Colors.green,
                                          ),
                                      ),
                                      const PopupMenuItem(
                                        value: 'delete',
                                        child: Icon(Icons.delete_rounded, color: Colors.red),
                                      ),
                                    ];
                                  },
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DiaryDetails(todo: items[index]))
                                  );
                                },
                              ),
                            ]
                        )
                    );
                },
              )
          ),
        ),



        floatingActionButton: FloatingActionButton.extended(
          onPressed: navigateToAddPage,
          label: const Text('Add Diary',
            style: TextStyle(
              fontFamily: "Mynerve",),
          ),
        )
    );
  }
  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(builder: (context) => const AddEditPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> navigateToEditTodo(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddEditPage(todo: item),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> deleteById(String id) async {
    final url = 'http://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if(response.statusCode == 200) {
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
        showSuccessMessage('Deleted successfully');
      });
    }
    else {
      showErrorMessage('Unable to Delete');
    }
  }

  Future<void> fetchTodo() async {
    setState(() {
      isLoading = true;
    });
    const url = 'http://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  void showSuccessMessage(String message){
    final snackBar = SnackBar(
        content: Text(message,
            style: const TextStyle(
                color: Colors.green)
        )
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void showErrorMessage(String message){
    final snackBar = SnackBar(
        content: Text(message,
            style: const TextStyle(
                color: Colors.redAccent)
        )
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> showMyDialog(BuildContext context, String id, index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Diary Deletion?'),
          content: SingleChildScrollView(
            child: ListBody(
              children:const  <Widget>[
                //Text('Confirm Deletion?'),
                Text('Would you like to delete this Diary?'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Yes'),
              onPressed: () async{
                setState(() {
                  deleteById(id);
                  items.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}