import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';
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
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("My Farms"),
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
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                FarmModel farm = snapshot.data![index];
                return Card(
                  surfaceTintColor: ColorConstants.listViewSurfaceTintColor,
                  elevation: 1.5,
                  margin: EdgeInsets.fromLTRB(12.0, 5.0, 12.0, 5.0),
                  color: Colors.white,
                  child: ListTile(
                    title:Column(
                      children: [
                        SizedBox(height: 18.0),
                        Row(
                          children: [
                            Text(
                              farm.farmName ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: ColorConstants.listViewTitleTextColor,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              ' (${farm.farmType ?? ''})',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: ColorConstants.listViewSubTitleTextColor,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              '${farm.farmArea} ${farm.unit}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: ColorConstants.listViewSubTitleTextColor,
                              ),
                            ),
                            SizedBox(height: 8.0),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${farm.farmAddress ?? ''}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: ColorConstants.listViewSubTitleTextColor,
                          ),
                        ),
                        SizedBox(height: 28.0),
                      ],
                    ),
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
