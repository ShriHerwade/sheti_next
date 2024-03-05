import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/CropModel.dart';
import 'package:sheti_next/zebra/screen/farming/CreateCropScreen.dart';

class MyCropScreen extends StatefulWidget {
  const MyCropScreen({Key? key}) : super(key: key);

  @override
  _MyCropScreenState createState() => _MyCropScreenState();
}

class _MyCropScreenState extends State<MyCropScreen> {
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
            MaterialPageRoute(builder: (context) => CreateCrop()),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Crops "),
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
                child: Text("No Crops available."),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  CropModel crop = snapshot.data![index];

                  return Card(
                    elevation: 5.0,
                    margin: EdgeInsets.all(10.0),
                    child: ListTile(
                      title: Text(
                        crop.cropName ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${crop.area} ${crop.unit}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          Text(
                            'Start Date: ${DateFormat("dd-MM-yyyy").format(DateTime.parse(crop.startDate.toString()))}',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            'End Date: ${DateFormat("dd-MM-yyyy").format(DateTime.parse(crop.endDate.toString()))}',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
