import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sheti_next/zebra/common/widgets/responsive_util.dart';
import 'package:sheti_next/zebra/screen/farming/CropWiseExpense.dart';
import '../../../translations/locale_keys.g.dart';
import '../../constant/ColorConstants.dart';
import '../../constant/SizeConstants.dart';
import '../../dao/models/CropModel.dart';
import '../../dao/models/ExpensePieChartModel.dart';
import '../../dao/DbHelper.dart';
import '../../dao/models/ViewExpenseModel.dart';

Future<List<ExpensePieChartModel>> getExpenseForPieChartByCrop() async {
  List<ExpensePieChartModel> expenses =
      await DbHelper().getExpenseForPieChartByCrop();
  return expenses ?? [];
}

class MyPieChartWidget extends StatefulWidget {
  @override
  _MyPieChartWidgetState createState() => _MyPieChartWidgetState();
}

class _MyPieChartWidgetState extends State<MyPieChartWidget> {
  DbHelper? dbHelper;
  List<ExpensePieChartModel> _expenses = [];
  List<ViewExpenseModel> _latestExpenses = [];
  int touchedIndex = -1;

  // Index to keep track of the current color
  int colorIndex = 0;

  // Convert the hexadecimal colors to Color objects
  List<Color> pieChartColors = ColorConstants.pieChartHexColors
      .map((hexColor) =>
          Color(int.parse(hexColor.substring(1), radix: 16) + 0xFF000000))
      .toList();

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    _fetchData();
  }

  Future<void> _fetchData() async {
    List<ExpensePieChartModel> expenses = await getExpenseForPieChartByCrop();
    List<ViewExpenseModel> latestExpenses =
        await DbHelper().getLatestExpenses();
    setState(() {
      _expenses = expenses;
      _latestExpenses = latestExpenses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        /* appBar: AppBar(
          title: Text('Expense Overview'),
        ),*/
        body: Container(
          height: ResponsiveUtil.screenHeight(context),
          width: ResponsiveUtil.screenWidth(context),
          child: Column(
            children: [
              Column(
                children: [
                  if (_expenses.isEmpty)
                    _expenses == null
                        ? Center(child: Text('No records to show'))
                        : Center(child: CircularProgressIndicator())
                  else
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: ResponsiveUtil.screenHeight(context) * 0.3,
                            // width: ResponsiveUtil.screenWidth(context) * 0.1,
                            child: PieChart(
                              PieChartData(
                                sections: _expenses.map((expense) {
                                  // Get the color from the list based on the current index
                                  Color selectedColor =
                                      pieChartColors[colorIndex];

                                  // Increment the index for the next section
                                  colorIndex =
                                      (colorIndex + 1) % pieChartColors.length;

                                  return PieChartSectionData(
                                    radius: 99.0,
                                    title: expense.cropName,
                                    value: expense.totalAmountSpent.toDouble(),
                                    color: selectedColor,
                                    titleStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  );
                                }).toList(),
                                borderData: FlBorderData(show: false),
                                sectionsSpace: 5.0,
                                centerSpaceRadius: 20,
                                //sections: showingSections(),
                              ),
                            ),
                          ),
                          Container(
                            height: ResponsiveUtil.screenHeight(context) * 0.55,
                            child: FutureBuilder<List<CropModel>>(
                              future: dbHelper!.getAllCrops(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text("Error: ${snapshot.error}"),
                                  );
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return Center(
                                    child: Text(LocaleKeys
                                        .labelMessageNoCropAvailable
                                        .tr()),
                                  );
                                } else {
                                  return ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      CropModel crop = snapshot.data![index];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CropWiseExpenses(
                                                cropId: crop.cropId ?? 0,
                                                cropName: crop.cropName,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Card(
                                          surfaceTintColor: ColorConstants
                                              .listViewSurfaceTintColor,
                                          elevation: 1.5,
                                          margin: EdgeInsets.fromLTRB(
                                              12.0, 5.0, 12.0, 5.0),
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(height: 18.0),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            crop.cropName ?? '',
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  SizeConstants
                                                                      .listViewDataFontSemiBold,
                                                              fontSize:
                                                                  SizeConstants
                                                                      .listViewData16FontSize,
                                                              color: ColorConstants
                                                                  .listViewTitleTextColor,
                                                            ),
                                                          ),
                                                          SizedBox(width: 5),
                                                          // Adjust spacing between cropName and dot as needed
                                                          // Dot based on cropLifeState
                                                          crop.cropLifeState ==
                                                                  'Live'
                                                              ? Icon(
                                                                  Icons.circle,
                                                                  size: 15,
                                                                  color: Colors
                                                                      .green, // Green dot for Live
                                                                )
                                                              : Icon(
                                                                  Icons.circle,
                                                                  size: 15,
                                                                  color: Colors
                                                                      .grey, // Grey dot for Dead or null
                                                                ),
                                                          Text(
                                                            '  ${crop.area} ${crop.unit}',
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize:
                                                                  SizeConstants
                                                                      .listViewData16FontSize,
                                                              color: ColorConstants
                                                                  .listViewTitleTextColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            crop.farmName,
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize:
                                                                  SizeConstants
                                                                      .listViewData16FontSize,
                                                              color: ColorConstants
                                                                  .listViewChildTextColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 8.0),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '${LocaleKeys.labelSeason.tr()} : ${DateFormat("dd MMM yyyy").format(crop.startDate)} - ${DateFormat("dd MMM yyyy").format(crop.endDate)}',
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize:
                                                                  SizeConstants
                                                                      .listViewData16FontSize,
                                                              color: ColorConstants
                                                                  .listViewChildTextColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 15.0),
                                                    ],
                                                  ),
                                                ),
                                                Icon(Icons.arrow_forward_ios),
                                                // Forward arrow icon
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
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
