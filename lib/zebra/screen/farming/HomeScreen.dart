import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sheti_next/zebra/common/widgets/NxNavBar.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/CropModel.dart';
import 'package:sheti_next/zebra/dao/models/FarmModel.dart';
import 'package:sheti_next/zebra/screen/farming/CreateCropScreen.dart';
import 'package:sheti_next/zebra/screen/farming/CreateFarmScreen.dart';
import 'package:sheti_next/zebra/screen/farming/CreateExpenseScreen.dart';
import 'package:sheti_next/zebra/screen/farming/CreateIncomeScreen.dart';
import 'package:sheti_next/zebra/screen/farming/CreateTaskScreen.dart';
import 'package:sheti_next/zebra/screen/farming/DashboardScreen.dart';
import 'package:sheti_next/zebra/screen/farming/ExpenseAndAllExpensesScreen.dart';
import 'package:sheti_next/zebra/screen/farming/MyCropScreen.dart';
import 'package:sheti_next/zebra/screen/farming/MyExpensesScreen.dart';
import 'package:sheti_next/zebra/screen/farming/MyFarmScreen.dart';
import 'package:sheti_next/zebra/screen/farming/MyIncomeScreen.dart';
import 'package:sheti_next/zebra/screen/farming/MyTaskScreen.dart';
import 'package:sheti_next/zebra/screen/farming/MyTaskTimeline.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalFarms = 0;
  int totalCrops = 0;
  double totalArea = 0;

  final dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();
    fetchStatistics();
  }

  void fetchStatistics() {
    dbHelper.getAllFarms().then((List<FarmModel> farms) {
      setState(() {
        totalFarms = farms.length;
        totalArea = farms.fold(0, (previousValue, farm) => previousValue + farm.farmArea);
      });
    });

    dbHelper.getAllCrops().then((List<CropModel> crops) {
      setState(() {
        totalCrops = crops.length;
      });
    });
  }

  Widget _buildButtonContainer(String text, IconData iconData, VoidCallback onPressed, Widget destinationScreen) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationScreen),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, backgroundColor: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
           // child: Icon(iconData),
          ),
          Center(
            child: Text(text),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NxNavBar(),
      appBar: AppBar(
        title: Text("Home Page"),
      ),
        bottomNavigationBar: GNav(
          backgroundColor: Colors.white,
          color: Colors.black,
          tabBackgroundColor: Colors.lightGreen,
          padding: EdgeInsets.all(16),
          gap: 8,
          tabs: [
            GButton(icon: Icons.home, text: "Home"),
            GButton(icon: Icons.local_activity, text: "Activity"),
            GButton(icon: Icons.add, text: ""),
            GButton(icon: Icons.notifications, text: "Notification"),
            GButton(icon: Icons.ac_unit, text: "Other"),
          ],
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
                  Expanded(
                    child: Card(
                      elevation: 0.0,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(totalFarms.toString(), style: TextStyle(fontSize: 26)),
                            SizedBox(height: 10),
                            Text("Total Farms", style: TextStyle(fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      elevation: 0.0,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(totalCrops.toString(), style: TextStyle(fontSize: 26)),
                            SizedBox(height: 10),
                            Text("Total Crops", style: TextStyle(fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      elevation: 0.0,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(totalArea.toStringAsFixed(2), style: TextStyle(fontSize: 26)),
                            Text("acres"+ '\n' +"Total Area", style: TextStyle(fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: [
                  Card(
                    elevation: 0.0,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pending Tasks", style: TextStyle(fontWeight: FontWeight.normal)),
                          SizedBox(height: 10),
                          // Add functionality for displaying pending tasks
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0.0,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Total Income", style: TextStyle(fontWeight: FontWeight.normal)),
                          SizedBox(height: 10),
                          // Add functionality for displaying total income
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0.0,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Total Expenses", style: TextStyle(fontWeight: FontWeight.normal)),
                          SizedBox(height: 10),
                          // Add functionality for displaying total expenses
                        ],
                      ),
                    ),
                  ),

                  _buildButtonContainer("Create Farm", Icons.add, () {}, CreateFarms()),
                  _buildButtonContainer("View Farm", Icons.visibility, () {}, MyFarmScreen()),
                  _buildButtonContainer("Update Farm", Icons.edit, () {}, HomeScreen()),
                  _buildButtonContainer("Create Crop", Icons.add, () {}, CreateCrop()),
                  _buildButtonContainer("View Crop", Icons.visibility, () {}, MyCropScreen()),
                  _buildButtonContainer("Update Crop", Icons.edit, () {}, HomeScreen()),
                  _buildButtonContainer("Create Task", Icons.add, () {}, CreateTask()),
                  _buildButtonContainer("View Task", Icons.visibility, () {}, MyTask()),
                  _buildButtonContainer("Update Task", Icons.edit, () {}, HomeScreen()),
                  _buildButtonContainer("Add Expenses", Icons.add, () {}, CreateExpenses()),
                  _buildButtonContainer("Add Income", Icons.visibility, () {}, CreateIncomeScreen()),
                  _buildButtonContainer("Dashboard", Icons.edit, () {}, DashboardScreen()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
