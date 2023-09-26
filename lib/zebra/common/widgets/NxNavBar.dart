import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NxNavBar extends StatelessWidget {


   const NxNavBar({super.key});


  @override
  Widget build(BuildContext context) {

    return  Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(accountName: Text("Sachin"),
              accountEmail: Text("sachin@gmail.com"),
          currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Icon(
                    Icons.person
                ),
              )),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              image: DecorationImage(
                image: AssetImage('assets/images/astro1.jpg'),
                fit: BoxFit.cover
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title:Text("Home") ,
          ),
          ListTile(
            leading: Icon(Icons.share),
            title:Text("Share") ,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title:Text("Settings") ,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title:Text("Logout") ,
          )

        ],
      ),
    );
  }
}
