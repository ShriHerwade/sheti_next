import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/ExpenseModel.dart';
import 'package:sheti_next/zebra/screen/farming/CreateExpenseScreen.dart';// Import your DbHelper file

class MyExpenses extends StatefulWidget {
  @override
  _MyExpensesState createState() => _MyExpensesState();
}

class _MyExpensesState extends State<MyExpenses> {

  late DbHelper dbHelper;
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
        // Check if the swipe is a right swipe and not ambiguous or left swipe
        if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
          // Right swipe
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateExpenses()),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Expenses'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body:FutureBuilder<List<ExpenseModel>>(
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
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 26.0,
                  headingRowHeight: 60,
                  dataRowHeight: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  columns: [
                    DataColumn(
                      label: Text(
                        "Expense Type",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Expense Date",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Amount",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),

                  ],
                  rows: snapshot.data!.map((expense) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(
                            expense.expenseType ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                        DataCell(
                          Text(
                            DateFormat("dd-MM-yyyy")
                                .format(DateTime.parse(expense.expenseDate.toString())),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),

                        DataCell(
                          Text(
                        '${expense.amount}',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              );
            }
          },
        ),
          //above is pasted

      ),
    );
  }


}
