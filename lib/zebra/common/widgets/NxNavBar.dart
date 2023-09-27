import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sheti_next/zebra/screen/farming/MyFarmsScreen.dart';

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
              color: Colors.green.shade200,

              image: DecorationImage(
                image: AssetImage('assets/images/astro1.jpg'),
                fit: BoxFit.cover
              ),
            ),
          ),
          InkWell(
            onTap: (){

            },
            child: ExpansionTile(

              leading: Icon(Icons.crop_original),
              title:Text("Farms") ,

              children: [
                ListTile(
                  leading: Icon(Icons.share),
                  title:Text("Crops") ,

                ),
                ListTile(
                  leading: Icon(Icons.money),
                  title:Text("Expenses") ,
                ),
              ],
            ),
          ),
          Divider(),

          Divider(),
          ListTile(
            leading: Icon(Icons.event),
            title:Text("Events") ,
          ),
          Divider(),


        ],
      ),
    );
  }
}
