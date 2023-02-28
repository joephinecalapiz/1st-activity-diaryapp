import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


/// save image on cache using shared_preferences throw image's path

File? imgFile;
String? imgPath;

class DiaryDetails extends StatefulWidget {
  final dynamic todo;

  const DiaryDetails({Key? key, this.todo}) : super(key: key);

  @override
  State<DiaryDetails> createState() => _DiaryDetailsState();
}

class _DiaryDetailsState extends State<DiaryDetails> {
  final double coverHeight = 280;
  final double profileHeight = 144;

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
            Padding(
                padding: const EdgeInsets.only(right: 1.0),
                child: InkWell(
                    onTap: () {
                      getImg();
                    },
                    child: const Icon(Icons.image_outlined,
                        color: Colors.green, size: 35))),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                if (imgPath != null)
                  Expanded(
                      child: Image.file(File(imgPath!),
                          width: double.infinity,
                          height: coverHeight,
                          fit: BoxFit.cover)),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                columnTitle(
                  "Title",
                  widget.todo['title'],
                ),
                columnDescription("Description", widget.todo["description"])
              ],
            ),
          ],
        ));
  }

  Widget columnTitle(String title, dynamic value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 1),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 40,
            fontFamily: "Mynerve",
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget columnDescription(String description, dynamic value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 50),
        Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontFamily: "Oranienbaum",
          ),
        ),
        )],
    );
  }


  // get image from gallery
  void getImg() async {
    final pickedImage =
    await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      saveData(pickedImage.path.toString()); // path cache
      setState(() {
        imgFile = File(pickedImage.path);
      });
    }
  }

  void saveData(String val) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString('path', val);
    getData();
  }

  void getData() async {
    final sharedPref = await SharedPreferences.getInstance();
    setState(() {
      imgPath = sharedPref.getString('path');
    });
  }

  void deleteData() async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.remove('path');
    getData();
  }
}
