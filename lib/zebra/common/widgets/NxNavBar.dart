import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sheti_next/translations/locale_keys.g.dart';
import 'package:sheti_next/zebra/screen/farming/CreateCropScreen.dart';
import 'package:sheti_next/zebra/screen/farming/CreateEventScreen.dart';
import 'package:sheti_next/zebra/screen/farming/CreateExpenseScreen.dart';
import 'package:sheti_next/zebra/screen/farming/CreateFarmScreen.dart';
import 'package:sheti_next/zebra/screen/farming/MyExpensesScreen.dart';
import 'package:sheti_next/zebra/screen/farming/MyFarmScreen.dart';
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
              title: Text(LocaleKeys.navBarDiary.tr()),
              children: [
                ListTile(
                  leading: Icon(Icons.landslide),
                  title: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => CreateFarms()));
                      },
                      child: Text(LocaleKeys.navBarFarms.tr())),
                ),
                ListTile(
                  leading: Icon(Icons.trending_up),
                  title: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => CreateCrop()));
                      },
                      child: Text(LocaleKeys.navBarCrops.tr())),
                ),
                ListTile(
                  leading: Icon(Icons.task_alt),
                  title: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => CreateEvents()));
                      },
                      child: Text(LocaleKeys.navBarEvents.tr())),
                ),
                ListTile(
                  leading: Icon(Icons.payments),
                  title: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CreateExpenses()));
                      },
                      child: Text(LocaleKeys.navBarExpenses.tr())),
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.pets),
            title: Text(LocaleKeys.navBarHusbandry.tr()),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.fire_truck),
            title: Text(LocaleKeys.navBarMachinery.tr()),
          ),
          Divider(),
          ExpansionTile(
              leading: Icon(Icons.g_translate),
              title: Text(LocaleKeys.navBarLanguages.tr()),
              children: [
                ListTile(
                  title: InkWell(
                      onTap: () {
                        context.setLocale(Locale('mr'));
                      },
                      child: Text(LocaleKeys.navBarLangMarathi.tr())),
                ),
                ListTile(
                  title: InkWell(
                      onTap: () {
                        context.setLocale(Locale('en'));
                      },
                      child: Text(LocaleKeys.navBarLangEnglish.tr())),
                ),
              ]),
          Divider(),
        ],
      ),
    );
  }
}
