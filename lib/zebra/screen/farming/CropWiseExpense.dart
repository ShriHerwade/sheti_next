import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';
import 'package:sheti_next/zebra/constant/SizeConstants.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/ExpenseModel.dart';
import 'package:sheti_next/zebra/screen/farming/CreateExpenseScreen.dart';

import 'HomeScreen.dart';

class CropWiseExpenses extends StatefulWidget {
  final int cropId;
  final String cropName;// Add cropId parameter
  const CropWiseExpenses({Key? key, required this.cropId, required this.cropName}) : super(key: key);
  @override
  _CropWiseExpensesState createState() => _CropWiseExpensesState();
}

class _CropWiseExpensesState extends State<CropWiseExpenses> {
  late DbHelper dbHelper;
  bool isHovered = false;

  @override
  void initState() {
    super.initState();
    initializeDbHelper();
    _fetchExpensesByCropId();
  }

  Future<void> initializeDbHelper() async {
    dbHelper = DbHelper();
    await dbHelper.initDb();
    setState(() {});
  }
  Future<List<ExpenseModel>> _fetchExpensesByCropId() async {
    return dbHelper!.getExpenseByCropId(widget.cropId);
  }
  @override
  Widget build(BuildContext context) {
    if (dbHelper == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>HomeScreen()),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text(widget.cropName+ " " + 'Expenses'),
          centerTitle: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: ColorConstants.miniIconDefaultColor),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
        ),
        body: FutureBuilder<List<ExpenseModel>>(
          future: dbHelper.getAllExpense(),
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
                child: Text("No Expenses available."),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  ExpenseModel expense = snapshot.data![index];

                  return InkWell(
                    onTap: () {
                      // Handle card tap
                    },
                    onHover: (hover) {
                      setState(() {
                        isHovered = hover;
                      });
                    },
                    child: Card(
                      surfaceTintColor: ColorConstants.listViewSurfaceTintColor,
                      elevation: 1.5,
                      margin: EdgeInsets.fromLTRB(12.0, 5.0, 12.0, 5.0),
                      color: Colors.white,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(15.0),
                        title: Row(
                          children: [

                            Text(
                              expense.expenseType ?? '',
                              style: TextStyle(
                                fontWeight: SizeConstants.listViewDataFontSemiBold,
                                fontSize: SizeConstants.listViewData16FontSize,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8.0),
                            Text(
                              '${DateFormat("dd-MM-yyyy").format(DateTime.parse(expense.expenseDate.toString()))}',
                              style: TextStyle(color: Colors.grey),
                            ),
                            //SizedBox(height: 8.0),
                          ],
                        ),
                        trailing: Text(
                          '\₹${expense.amount}',
                          style: TextStyle(
                            fontWeight: SizeConstants.listViewDataFontSemiBold,
                            fontSize: SizeConstants.listViewData16FontSize,
                            color: Colors.black,
                          ),
                        ),
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
