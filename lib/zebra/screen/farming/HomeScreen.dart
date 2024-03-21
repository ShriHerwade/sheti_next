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
import 'package:sheti_next/zebra/screen/farming/ExpenseInsight.dart';
import 'package:sheti_next/zebra/screen/farming/MyCropScreen.dart';
import 'package:sheti_next/zebra/screen/farming/MyExpensesScreen.dart';
import 'package:sheti_next/zebra/screen/farming/MyFarmScreen.dart';
import 'package:sheti_next/zebra/screen/farming/MyIncomeScreen.dart';
import 'package:sheti_next/zebra/screen/farming/MyTaskScreen.dart';
import 'package:sheti_next/zebra/screen/farming/MyTaskTimeline.dart';

import 'ExpenseIncomeScreen.dart';

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

  get expenses => dbHelper.getAllExpense();

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

  Widget _buildButtonContainer(String text, String imagePath, VoidCallback onPressed, Widget destinationScreen) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationScreen),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 8,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          Center(
            child: Image.asset(
              imagePath,
              width: 110, // Adjust width as needed
              height: 110, // Adjust height as needed
            ),
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
        centerTitle: false,
        title: Text("Home"),
      ),
      bottomNavigationBar: GNav(
        backgroundColor: Colors.white,
        color: Colors.black,
        tabBackgroundColor: Colors.green,
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
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0)
                ),
                child: Row(
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
                              Text("This week"),
                              Text(totalFarms.toString(), style: TextStyle(fontSize: 26)),
                              SizedBox(height: 10),
                              Text("Task Pending", style: TextStyle(fontWeight: FontWeight.normal)),
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
                              Text(""),
                              Text(totalCrops.toString(), style: TextStyle(fontSize: 26)),
                              SizedBox(height: 10),
                              Text("Total"+'\n' "Income", style: TextStyle(fontWeight: FontWeight.normal)),
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
                              Text(""),
                              Text("0", style: TextStyle(fontSize: 26)),
                              SizedBox(height: 10),
                              Text("Total Expenses", style: TextStyle(fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: [
                  _buildButtonContainer("Create Farm", "assets/icons/home/create_farm_ic_2.png", () {}, CreateFarms()),
                  _buildButtonContainer("View Farm", "assets/icons/home/view_farm_ic_2.png", () {}, MyFarmScreen()),
                  //_buildButtonContainer("Update Farm", Icons.edit, () {}, HomeScreen()),
                  _buildButtonContainer("Create Crop", "assets/icons/home/create_crop_ic_2.png", () {}, CreateCrop()),
                  _buildButtonContainer("View Crop", "assets/icons/home/view_crop_ic_2.png", () {}, MyCropScreen()),
                  //_buildButtonContainer("Update Crop", Icons.edit, () {}, HomeScreen()),
                  _buildButtonContainer("Create Task", "assets/icons/home/create_task_ic_3.png", () {}, CreateTask()),
                  _buildButtonContainer("View Task", "assets/icons/home/view_task_ic_2.png", () {}, MyTask()),
                  //_buildButtonContainer("Update Task", Icons.edit, () {}, HomeScreen()),
                  _buildButtonContainer("Add Transaction", "assets/icons/home/create_transaction_ic_2.png", () {}, ExpenseIncomeScreen()),
                  _buildButtonContainer("View Transaction", "assets/icons/home/view_transaction_ic_2.png", () {}, HomeScreen()),
                  //_buildButtonContainer("Add Income", Icons.visibility, () {}, CreateIncomeScreen()),
                  _buildButtonContainer("View Income", "assets/icons/home/view_income_ic_2.png", () {}, HomeScreen()),
                  _buildButtonContainer("View Expense", "assets/icons/home/view_expense_ic_2.png", () {}, HomeScreen()),
                  _buildButtonContainer("Add Yield", "assets/icons/home/create_yield_ic_2.png", () {}, HomeScreen()),
                  _buildButtonContainer("View Yield", "assets/icons/home/view_yield_ic_2.png", () {}, HomeScreen()),
                  _buildButtonContainer("Dashboard", "assets/icons/home/dashboard_ic_3.png", () {}, ExpenseInsightPage(expenses: expenses)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}