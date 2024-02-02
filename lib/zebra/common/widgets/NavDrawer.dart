import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/screen/farming/CreateCropScreen.dart';
import 'package:sheti_next/zebra/screen/farming/CreateFarmScreen.dart';
import 'package:sheti_next/zebra/screen/farming/DashboardScreen.dart';
import 'package:sheti_next/zebra/screen/farming/ExpenseIncomeScreen.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'My Profile',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/astro1.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Farm'),
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => CreateFarms()))
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Crop'),
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => CreateCrop()))
            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Dashboard'),
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => DashboardScreen()))
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Expense'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ExpenseIncomeScreen()))
            },
          ),
        ],
      ),
    );
  }
}
