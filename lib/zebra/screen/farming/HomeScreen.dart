import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/common/widgets/NxNavBar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NxNavBar(),
      bottomNavigationBar: GNav(
        backgroundColor: Colors.lightGreen,
        color: Colors.white,
        // activeColor: Colors.,
        tabBackgroundColor: Colors.green,
        padding: EdgeInsets.all(16),
        gap: 8,
        tabs: [
          GButton(
            icon: Icons.home,
            text: "Home",
          ),
          GButton(icon: Icons.local_activity, text: "Activity"),
          GButton(icon: Icons.add, text: ""),
          GButton(
            icon: Icons.notifications,
            text: "Notification",
          ),
          GButton(
            icon: Icons.ac_unit,
            text: "Other",
          ),
        ],
      ),
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Container(),
    );
  }
}
