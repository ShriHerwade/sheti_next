import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/CropModel.dart';
import 'package:sheti_next/zebra/screen/farming/CreateCropScreen.dart';
import 'package:intl/intl.dart';

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
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("My Crops"),
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
                return Card(
                  surfaceTintColor: ColorConstants.listViewSurfaceTintColor,
                  elevation: 1.5,
                  margin: EdgeInsets.fromLTRB(12.0, 5.0, 12.0, 5.0),
                  color: Colors.white,
                  child: ExpansionTile(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    title: Column(
                      children: [
                        SizedBox(height: 18.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              crop.cropName ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18.0,
                                color: ColorConstants.listViewTitleTextColor,
                              ),
                            ),

                            Text(
                              '  ${crop.area} ${crop.unit}',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16.0,
                                color:ColorConstants.listViewTitleTextColor,
                              ),
                            ),
                            /*Icon(
                              Icons.calendar_month_sharp, // Use the calendar icon from the Material Icons library
                              color: Colors.grey, // Adjust the color of the icon as needed
                            ),*/
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Season : ${DateFormat("dd MMM yyyy").format(crop.startDate)} - ${DateFormat("dd MMM yyyy").format(crop.endDate)}',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16.0,
                                color: ColorConstants.listViewChildTextColor,
                              ),
                            ),
                            /*SizedBox(width: 20.0),
                            Text(
                              'End Date: ${DateFormat("dd-MM-yyyy").format(crop.endDate)}',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16.0,
                                color: ColorConstants.listViewChildTextColor,
                              ),
                            ),*/
                          ],
                        ),
                        SizedBox(height: 15.0),
                      ],
                    ),

                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.all(15.0),
                        title: Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Expected",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 14.0,
                                        color: ColorConstants
                                            .listViewChildTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Yeild : 20 Tons",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14.0,
                                        color: ColorConstants.listViewChildTextColor,
                                      ),
                                    ),

                                    Text(
                                     "Income : 12000/-",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14.0,
                                        color: ColorConstants.listViewChildTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    Text(
                                      "Total",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 14.0,
                                        color: ColorConstants
                                            .listViewChildTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,

                                  children: [
                                    Text(
                                      "Expenses: 35000/-",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14.0,
                                        color:ColorConstants.listViewTitleTextColor,
                                      ),
                                    ),
                                    SizedBox(width: 9.0),
                                    Text(
                                     "Income: 55000/-",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14.0,
                                        color: ColorConstants.listViewChildTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // Add more fields as needed
                          ],
                        ),
                      ),
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
