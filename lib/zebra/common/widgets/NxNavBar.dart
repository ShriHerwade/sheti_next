import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sheti_next/zebra/screen/farming/MyFarmsScreen.dart';

class NxNavBar extends StatelessWidget {
  const NxNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Sachin"),
            accountEmail: Text("sachin@gmail.com"),
            currentAccountPicture: CircleAvatar(
                child: ClipOval(
              child: Icon(Icons.person),
            )),
            decoration: BoxDecoration(
              color: Colors.green.shade200,
              image: DecorationImage(
                  image: AssetImage('assets/images/astro1.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ExpansionTile(
              leading: Icon(Icons.book),
              title: Text("Diary"),
              children: [
                ListTile(
                  leading: Icon(Icons.landslide),
                  title: Text("Farms"),
                ),
                ListTile(
                  leading: Icon(Icons.trending_up),
                  title: Text("Crops"),
                ),
                ListTile(
                  leading: Icon(Icons.event),
                  title: Text("Events"),
                ),
                ListTile(
                  leading: Icon(Icons.attach_money_outlined),
                  title: Text("Expenses"),
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.pets),
            title: Text("Husbandry"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.fire_truck),
            title: Text("Machinary"),
          ),
          Divider(),
        ],
      ),
    );
  }
}
