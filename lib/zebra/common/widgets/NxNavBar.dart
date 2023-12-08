import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sheti_next/translations/locale_keys.g.dart';
import 'package:sheti_next/zebra/screen/farming/CreateCropScreen.dart';
import 'package:sheti_next/zebra/screen/farming/CreateEventScreen.dart';
import 'package:sheti_next/zebra/screen/farming/CreateExpenseScreen.dart';
import 'package:sheti_next/zebra/screen/farming/CreateFarmScreen.dart';
import 'package:sheti_next/zebra/screen/farming/MyExpensesScreen.dart';
import 'package:sheti_next/zebra/screen/farming/MyFarmsScreen.dart';
import '../../screen/farming/MyCropsScreen.dart';
import '../../screen/farming/MyEventsScreen.dart';

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
                  title: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => CreateFarms()));
                      },
                      child: Text("Farms")),
                ),
                ListTile(
                  leading: Icon(Icons.trending_up),
                  title: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => CreateCrop()));
                      },
                      child: Text("Crops")),
                ),
                ListTile(
                  leading: Icon(Icons.event),
                  title: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => CreateEvents()));
                      },
                      child: Text("Events")),
                ),
                ListTile(
                  leading: Icon(Icons.attach_money_outlined),
                  title: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CreateExpenses()));
                      },
                      child: Text("Expenses")),
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
          ExpansionTile(
            title: Text("Change Language"),
            children:[
              ListTile(
                leading: Icon(Icons.language_outlined),
                title: InkWell(
                    onTap: () {
                      context.setLocale(Locale('mr'));
                    },
                    child: Text("Marathi")),

              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.language_outlined),
                title: InkWell(
                    onTap: () {
                      context.setLocale(Locale('en'));
                    },
                    child: Text("English")),
              ),
    ]

          ),

          Divider(),
        ],
      ),
    );
  }
}
