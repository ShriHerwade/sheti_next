import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sheti_next/translations/locale_keys.g.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';
import 'package:sheti_next/zebra/constant/SizeConstants.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/FarmModel.dart';
import 'package:sheti_next/zebra/screen/farming/CreateFarmScreen.dart';
import 'package:sheti_next/zebra/screen/farming/HomeScreen.dart';

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
        title: Text(LocaleKeys.labelAppTitleMyFarm.tr()),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: ColorConstants.miniIconDefaultColor),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
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
              child: Text(LocaleKeys.labelMessageNoFarmAvailable.tr()),
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
                                fontWeight: FontWeight.w600,
                                fontSize:  SizeConstants.listViewDataFontSize,
                                color: ColorConstants.listViewTitleTextColor,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              ' (${farm.farmType ?? ''})',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize:  SizeConstants.listViewDataFontSize,
                                color: ColorConstants.listViewChildTextColor,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              '${farm.farmArea} ${farm.unit}',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize:  SizeConstants.listViewDataFontSize,
                                color: ColorConstants.listViewChildTextColor,
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
                            fontWeight: FontWeight.normal,
                            fontSize:  SizeConstants.listViewDataFontSize,
                            color: ColorConstants.listViewChildTextColor,
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
