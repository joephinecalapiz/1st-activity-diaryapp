import 'package:diaryapp/pages/help_page.dart';
import 'package:diaryapp/pages/home_page.dart';
import 'package:diaryapp/pages/homescreen_page.dart';
import 'package:diaryapp/pages/login_page.dart';
import 'package:diaryapp/pages/privacy_page.dart';
import 'package:diaryapp/pages/profile_page.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.cyan,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 50),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/images/amor.jpg'),
                      fit: BoxFit.fill
                      )
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text("Joephine Calapiz",
                      style: const TextStyle(
                          fontSize: 22,
                          fontFamily: "Mynerve",
                          fontWeight: FontWeight.bold,
                          color: Colors.white)
                  ),
                  const SizedBox(height: 5),

                  Text("joephinecalapiz7@gmail.com",
                      style: const TextStyle(
                          fontSize: 18,
                          fontFamily: "Mynerve",
                          //fontWeight: FontWeight.bold,
                          color: Colors.white)
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          ListTile(
            leading: Icon(Icons.person_rounded,
                size: 22,
                color: Colors.black87),
            title: Text('Profile',
                style: const TextStyle(
                    fontSize: 22,
                    fontFamily: "Oranienbaum",
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)
            ),
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage())
              );
            },
          ),
          SizedBox(height: 15),
          ListTile(
            leading: Icon(Icons.edit_note_outlined, size: 22,
                color: Colors.black87),
            title: Text('Diary',
                style: const TextStyle(
                    fontSize: 22,
                    fontFamily: "Oranienbaum",
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)
            ),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 15),
          ListTile(
            leading: Icon(Icons.calendar_month_rounded,
                size: 22,
                color: Colors.black87),
            title: Text('Calendar',
                style: const TextStyle(
                    fontSize: 22,
                    fontFamily: "Oranienbaum",
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)
            ),
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage())
              );
            },
          ),
          SizedBox(height: 15),
          ExpansionTile(
            leading: Icon(Icons.settings_rounded,
                size: 22,
                color: Colors.black87),
            title: Text('Settings',
                style: const TextStyle(
                    fontSize: 22,
                    fontFamily: "Oranienbaum",
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)
            ),
            childrenPadding: EdgeInsets.only(left: 60),
            children: [
              ListTile(
                title: Text('Privacy Information',
                    style: const TextStyle(
                        fontSize: 15,
                        fontFamily: "Oranienbaum",
                        fontWeight: FontWeight.bold,
                        color: Colors.black87)),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivacyInformation())
                  );
                },
              ),
              ListTile(
                title: Text('Profile Help',
                    style: const TextStyle(
                        fontSize: 15,
                        fontFamily: "Oranienbaum",
                        fontWeight: FontWeight.bold,
                        color: Colors.black87)),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileHelp())
                  );
                },
              ),
            ],

          ),
          SizedBox(height: 50),
          ListTile(
            leading: Icon(Icons.logout_rounded,
                size: 22,
                color: Colors.black87),
            title: Text('Logout',
                style: const TextStyle(
                    fontSize: 22,
                    fontFamily: "Oranienbaum",
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)
            ),
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen())
              );
            },
          ),

        ],
      )
    );
  }
}
