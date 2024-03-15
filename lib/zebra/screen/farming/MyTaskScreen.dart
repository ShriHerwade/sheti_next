import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';
import 'package:sheti_next/zebra/constant/SizeConstants.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/CropModel.dart';
import 'package:intl/intl.dart';
import 'package:sheti_next/zebra/screen/farming/MyTaskTimeline.dart';

class MyTask extends StatefulWidget {
  const MyTask({Key? key}) : super(key: key);

  @override
  _MyTaskState createState() => _MyTaskState();
}

class _MyTaskState extends State<MyTask> {
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
        title: Text("My Tasks"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<CropModel>>(
        future: dbHelper!.getAllCrops(),
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
              child: Text("No crops available."),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                CropModel crop = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to MyEventTimeline page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyTaskTimeline(cropId: crop.cropId ?? 0),
                      ),
                    );
                  },
                  child: Card(
                    surfaceTintColor: ColorConstants.listViewSurfaceTintColor,
                    elevation: 1.5,
                    margin: EdgeInsets.fromLTRB(12.0, 5.0, 12.0, 5.0),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            crop.cropName ?? '',
                            style: TextStyle(
                              fontWeight: SizeConstants.listViewDataFontSemiBold,
                              fontSize: SizeConstants.listViewDataFontSize,
                              color: ColorConstants.listViewTitleTextColor,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Area: ${crop.area} ${crop.unit}',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: SizeConstants.listViewDataFontSize,
                              color: ColorConstants.listViewTitleTextColor,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Season: ${DateFormat("dd MMM yyyy").format(crop.startDate)} - ${DateFormat("dd MMM yyyy").format(crop.endDate)}',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: SizeConstants.listViewDataFontSize,
                              color: ColorConstants.listViewChildTextColor,
                            ),
                          ),
                          SizedBox(height: 8.0),
                        ],
                      ),
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
