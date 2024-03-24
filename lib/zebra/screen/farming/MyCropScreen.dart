import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sheti_next/translations/locale_keys.g.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';
import 'package:sheti_next/zebra/constant/SizeConstants.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/CropModel.dart';
import 'package:sheti_next/zebra/screen/farming/CreateCropScreen.dart';
import 'package:intl/intl.dart';
import 'package:sheti_next/zebra/screen/farming/HomeScreen.dart';

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
        title: Text(LocaleKeys.labelAppTitleMyCrop.tr()),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: ColorConstants.miniIconDefaultColor),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
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
              child: Text(LocaleKeys.labelMessageNoCropAvailable.tr()),
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
                              style: const TextStyle(
                                fontWeight: SizeConstants.listViewDataFontSemiBold,
                                fontSize: SizeConstants.listViewData16FontSize,
                                color: ColorConstants.listViewTitleTextColor,
                              ),
                            ),
                            SizedBox(width: 5), // Adjust spacing between cropName and dot as needed
                            // Dot based on cropLifeState
                            crop.cropLifeState == 'Live'
                                ? Icon(
                              Icons.circle,
                              size: 10,
                              color: Colors.green, // Green dot for Live
                            )
                                : Icon(
                              Icons.circle,
                              size: 10,
                              color: Colors.grey, // Grey dot for Dead or null
                            ),

                            Text(
                              '  ${crop.area} ${crop.unit}',
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize:  SizeConstants.listViewData16FontSize,
                                color:ColorConstants.listViewTitleTextColor,
                              ),
                            ),
                            /*Icon(
                              Icons.calendar_month_sharp, // Use the calendar icon from the Material Icons library
                              color: Colors.grey, // Adjust the color of the icon as needed
                            ),*/
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              crop.farmName,
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: SizeConstants.listViewData16FontSize,
                                color: ColorConstants.listViewChildTextColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${LocaleKeys.labelSeason.tr()} : ${DateFormat("dd MMM yyyy").format(crop.startDate)} - ${DateFormat("dd MMM yyyy").format(crop.endDate)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize:  SizeConstants.listViewData16FontSize,
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
                                      LocaleKeys.labelExpected.tr(),
                                      style: TextStyle(
                                        fontWeight: SizeConstants.listViewDataFontSemiBold,
                                        fontSize:  SizeConstants.listViewData16FontSize,
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
                                      "${LocaleKeys.labelYield.tr()} : ${crop.expectedYield} ${crop.expectedYieldUnit}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize:  SizeConstants.listViewData16FontSize,
                                        color: ColorConstants.listViewChildTextColor,
                                      ),
                                    ),

                                    Text(
                                     "${LocaleKeys.labelIncome.tr()} : ${crop.expectedIncome}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize:  SizeConstants.listViewData16FontSize,
                                        color: ColorConstants.listViewChildTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                 Row(
                                  children: [
                                    Text(
                                      LocaleKeys.labelTotal.tr(),
                                      style: TextStyle(
                                        fontWeight: SizeConstants.listViewDataFontSemiBold,
                                        fontSize:  SizeConstants.listViewData16FontSize,
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
                                      "${LocaleKeys.labelExpense.tr()}: ${crop.totalExpense}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize:  SizeConstants.listViewData16FontSize,
                                        color:ColorConstants.listViewTitleTextColor,
                                      ),
                                    ),
                                    SizedBox(width: 9.0),
                                    Text(
                                     "${LocaleKeys.labelIncome.tr()}: ${crop.totalIncome}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize:  SizeConstants.listViewData16FontSize,
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
