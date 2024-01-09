import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/FarmModel.dart';
import 'package:sheti_next/zebra/screen/farming/CreateFarmScreen.dart';

class MyFarmScreen extends StatefulWidget {
  const MyFarmScreen({Key? key}) : super(key: key);

  @override
  _MyFarmScreenState createState() => _MyFarmScreenState();
}

class _MyFarmScreenState extends State<MyFarmScreen> {
  DbHelper? dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        // Check if the swipe is a right swipe and not ambiguous or left swipe
        if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
          // Right swipe
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CreateFarms()),

          );

        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Farms "),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder<List<FarmModel>>(
          future: dbHelper!.getAllFarms(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text("No farms available."),
              );
            } else {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 26.0, // Increased space between columns
                  headingRowHeight: 60,
                  dataRowHeight: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  columns: [
                    DataColumn(
                      label: Text(
                        "Farm Name",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Address",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Area",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Type",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),
                  ],
                  rows: snapshot.data!.map((farm) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(
                            farm.farmName ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                        DataCell(
                          Text(
                            farm.farmAddress ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                        DataCell(
                          Text(
                            '${farm.farmArea} ${farm.unit}',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                        DataCell(
                          Text(
                            farm.farmType ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
