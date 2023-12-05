import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/FarmModel.dart';

class FarmsListScreen extends StatefulWidget {
  const FarmsListScreen({Key? key}) : super(key: key);

  @override
  _FarmsListScreenState createState() => _FarmsListScreenState();
}

class _FarmsListScreenState extends State<FarmsListScreen> {
  DbHelper? dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Farms List"),
        centerTitle: true,
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
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                FarmModel farm = snapshot.data![index];
                return Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Farm Name: ${farm.farmName}"),
                      Text("Address: ${farm.farmAddress}"),
                      Text("Area: ${farm.farmArea} ${farm.unit}"),
                      Text("Type: ${farm.farmType}"),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
