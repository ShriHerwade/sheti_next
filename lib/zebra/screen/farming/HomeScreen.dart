import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/common/widgets/NxNavBar.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';
import '../../common/widgets/NavDrawer.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sheti_next/zebra/dao/models/FarmModel.dart';
import 'package:sheti_next/zebra/dao/models/CropModel.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart'; // Import DbHelper model

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalFarms = 0; // To store total number of farms
  int totalCrops = 0; // To store total number of crops
  double totalArea = 0; // To store total area under cultivation

  // Create an instance of DbHelper
  final dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();
    fetchStatistics(); // Fetch statistics when the widget initializes
  }

  // Function to fetch statistics
  void fetchStatistics() {
    // Call getAllFarms() and getAllCrops() methods on the dbHelper instance
    dbHelper.getAllFarms().then((List<FarmModel> farms) {
      // Calculate total number of farms
      totalFarms = farms.length;

      // Calculate total area under cultivation
      totalArea = farms.fold(
          0, (previousValue, farm) => previousValue + farm.farmArea);

      // Update the state after fetching farms
      setState(() {});
    });

    dbHelper.getAllCrops().then((List<CropModel> crops) {
      // Calculate total number of crops
      totalCrops = crops.length;

      // Update the state after fetching crops
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NxNavBar(),
      bottomNavigationBar: GNav(
        backgroundColor: Colors.white,
        color: Colors.black,
        // activeColor: Colors.,
        tabBackgroundColor: Colors.lightGreen,
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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey.shade200,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Card to display total number of farms
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Farms",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              totalFarms.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Card to display total number of crops
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Crops",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              totalCrops.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Card to display total area under cultivation
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Area",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              totalArea.toStringAsFixed(2) + " acres",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Button to create a farm
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: MediaQuery.of(context).size.height * 0.10,
                      padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white, // Adjust the color as needed
                    ),
                      child: Text("Pending Tasks")
                  ),
                  // Button to view farms
                  Container(
                    padding: EdgeInsets.all(12),
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: MediaQuery.of(context).size.height * 0.10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white, // Adjust the color as needed
                    ),
                      child: Text("Total Income")
                  ),
                  // Button to update farms
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: MediaQuery.of(context).size.height * 0.10,
                      padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white, // Adjust the color as needed
                    ),
                    child: Text("Total Expenses")
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Button to create a farm
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: MediaQuery.of(context).size.height * 0.10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white, // Adjust the color as needed
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Add functionality to create a farm
                      },
                      icon: Icon(Icons.add),
                      label: Text("Create Farm"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent, // Make button transparent
                        elevation: 0, // Remove button shadow
                      ),
                    ),
                  ),
                  // Button to view farms
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: MediaQuery.of(context).size.height * 0.10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white, // Adjust the color as needed
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Add functionality to view farms
                      },
                      icon: Icon(Icons.visibility),
                      label: Text("View Farm"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent, // Make button transparent
                        elevation: 0, // Remove button shadow
                      ),
                    ),
                  ),
                  // Button to update farms
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: MediaQuery.of(context).size.height * 0.10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white, // Adjust the color as needed
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Add functionality to update farms
                      },
                      icon: Icon(Icons.edit),
                      label: Text("Update Farm"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent, // Make button transparent
                        elevation: 0, // Remove button shadow
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Adding space between rows
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Button to create a crop
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: MediaQuery.of(context).size.height * 0.10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white, // Adjust the color as needed
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Add functionality to create a crop
                      },
                      icon: Icon(Icons.add),
                      label: Text("Create Crop"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent, // Make button transparent
                        elevation: 0, // Remove button shadow
                      ),
                    ),
                  ),
                  // Button to view crops
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: MediaQuery.of(context).size.height * 0.10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white, // Adjust the color as needed
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Add functionality to view crops
                      },
                      icon: Icon(Icons.visibility),
                      label: Text("View Crop"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent, // Make button transparent
                        elevation: 0, // Remove button shadow
                      ),
                    ),
                  ),
                  // Button to update crops
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: MediaQuery.of(context).size.height * 0.10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white, // Adjust the color as needed
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Add functionality to update crops
                      },
                      icon: Icon(Icons.edit),
                      label: Text("Update Crop"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent, // Make button transparent
                        elevation: 0, // Remove button shadow
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Adding space between rows
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Button to create a task
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: MediaQuery.of(context).size.height * 0.10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white, // Adjust the color as needed
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Add functionality to create a task
                      },
                      icon: Icon(Icons.add),
                      label: Text("Create Task"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent, // Make button transparent
                        elevation: 0, // Remove button shadow
                      ),
                    ),
                  ),
                  // Button to view tasks
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: MediaQuery.of(context).size.height * 0.10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white, // Adjust the color as needed
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Add functionality to view tasks
                      },
                      icon: Icon(Icons.visibility),
                      label: Text("View Task"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent, // Make button transparent
                        elevation: 0, // Remove button shadow
                      ),
                    ),
                  ),
                  // Button to update tasks
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: MediaQuery.of(context).size.height * 0.10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white, // Adjust the color as needed
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Add functionality to update tasks
                      },
                      icon: Icon(Icons.edit),
                      label: Text("Update Task"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent, // Make button transparent
                        elevation: 0, // Remove button shadow
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Adding space between rows
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Button to add expenses
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: MediaQuery.of(context).size.height * 0.10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white, // Adjust the color as needed
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Add functionality to add expenses
                      },
                      icon: Icon(Icons.add),
                      label: Text("Add Expenses"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent, // Make button transparent
                        elevation: 0, // Remove button shadow
                      ),
                    ),
                  ),
                  // Button to add income
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: MediaQuery.of(context).size.height * 0.10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white, // Adjust the color as needed
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Add functionality to add income
                      },
                      icon: Icon(Icons.visibility),
                      label: Text("Add Income"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent, // Make button transparent
                        elevation: 0, // Remove button shadow
                      ),
                    ),
                  ),
                  // Button to view dashboard
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: MediaQuery.of(context).size.height * 0.10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white, // Adjust the color as needed
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Add functionality to view dashboard
                      },
                      icon: Icon(Icons.edit),
                      label: Text("Dashboard"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent, // Make button transparent
                        elevation: 0, // Remove button shadow
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
