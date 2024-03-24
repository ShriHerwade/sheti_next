import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/ExpenseModel.dart';
import 'package:sheti_next/zebra/screen/farming/CreateExpenseScreen.dart';

import 'HomeScreen.dart';

class MyExpenses extends StatefulWidget {
  @override
  _MyExpensesState createState() => _MyExpensesState();
}

class _MyExpensesState extends State<MyExpenses> {
  late DbHelper dbHelper;
  bool isHovered = false;

  @override
  void initState() {
    super.initState();
    initializeDbHelper();
  }

  Future<void> initializeDbHelper() async {
    dbHelper = DbHelper();
    await dbHelper.initDb();
    setState(() {});
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
        appBar: AppBar(
          title: Text('My Expenses'),
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
                      elevation: 8.0,
                      margin: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(15.0),
                        title: Row(
                          children: [
                            Container(
                              width: 10.0,
                              height: 10.0,
                              decoration: BoxDecoration(
                                color: Colors.black, // Square bullet color
                                shape: BoxShape.rectangle,
                              ),
                              margin: EdgeInsets.only(right: 10.0),
                            ),
                            Text(
                              expense.expenseType ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
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
                              'Expense Date: ${DateFormat("dd-MM-yyyy").format(DateTime.parse(expense.expenseDate.toString()))}',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Amount: ${expense.amount}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
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
      ),
    );
  }
}
