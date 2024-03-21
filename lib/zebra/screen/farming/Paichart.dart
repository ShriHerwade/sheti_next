import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../dao/models/ExpensePieChartModel.dart';
import '../../dao/DbHelper.dart';
import '../../dao/models/ViewExpenseModel.dart';

// This is your existing method to retrieve data from the database
Future<List<ExpensePieChartModel>> getExpenseForPieChartByCrop() async {
  List<ExpensePieChartModel> expenses = await DbHelper().getExpenseForPieChartByCrop();
  return expenses ?? []; // Return empty list if expenses is null
}

class MyPieChartWidget extends StatefulWidget {
  @override
  _MyPieChartWidgetState createState() => _MyPieChartWidgetState();
}

class _MyPieChartWidgetState extends State<MyPieChartWidget> {
  List<ExpensePieChartModel> _expenses = [];
  List<ViewExpenseModel> _latestExpenses = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    List<ExpensePieChartModel> expenses = await getExpenseForPieChartByCrop();
    List<ViewExpenseModel> latestExpenses = await DbHelper().getLatestExpenses();
    setState(() {
      _expenses = expenses;
      _latestExpenses = latestExpenses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _expenses.isEmpty
                ? (_expenses == null
                ? Text('No records to show')
                : CircularProgressIndicator())
                : Container(
              padding: EdgeInsets.all(16.0), // Add padding around the chart
              child: SizedBox(
                width: 300.0, // Set width to control size of the chart
                height: 300.0, // Set height to control size of the chart
                child: PieChart(
                  PieChartData(
                    sections: _expenses.map((expense) {
                      return PieChartSectionData(
                        title: expense.cropName,
                        value: expense.totalAmountSpent.toDouble(),
                        color: Color((expense.cropName.hashCode & 0xFFFFFF) | 0xFF000000),
                        titleStyle: TextStyle(color: Colors.white), // Set text color to white
                      );
                    }).toList(),
                    borderData: FlBorderData(show: false), // Hide border
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Latest Expenses',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _latestExpenses.isEmpty
                ? Text('No latest expenses')
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _latestExpenses.map((expense) {
                return ListTile(
                  title: Text('${expense.farmName} - ${expense.cropName}'),
                  subtitle: Text('${expense.expenseType} - ${expense.amount.toString()}'),
                  trailing: Text('${expense.expenseDate.toString()}'),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
