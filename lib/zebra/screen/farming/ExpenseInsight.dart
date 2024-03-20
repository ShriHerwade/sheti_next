import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sheti_next/zebra/dao/models/ExpenseModel.dart';
import 'package:sheti_next/zebra/dao/models/ExpensePieChartModel.dart';
import 'package:sheti_next/zebra/dao/models/ExpenseBarChartModel.dart';
import 'package:sheti_next/zebra/dao/models/ViewExpenseModel.dart';

import '../../dao/DbHelper.dart';

class ExpenseInsightPage extends StatefulWidget {
  final Future<List<ExpenseModel>> expenses;

  ExpenseInsightPage({required this.expenses});

  @override
  _ExpenseInsightPageState createState() => _ExpenseInsightPageState();
}

class _ExpenseInsightPageState extends State<ExpenseInsightPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<ViewExpenseModel> latestExpenses = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchLatestExpenses();
    _tabController = TabController(length: 3, vsync: this);
  }
  Future<void> fetchLatestExpenses() async {
    try {
      List<ViewExpenseModel> expenses = await DbHelper().getLatestExpenses();
      setState(() {
        latestExpenses = expenses;
      });
    } catch (e) {
      print('Error getting latest expenses: $e');
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Insight'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Latest'),
            Tab(text: 'Crop-wise'),
            Tab(text: 'Farm-wise'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildChart('Latest', widget.expenses, ChartType.PieChart),
          _buildChart('Crop-wise', widget.expenses, ChartType.PieChart),
          _buildChart('Farm-wise', widget.expenses, ChartType.BarChart),
        ],
      ),
    );
  }

  Widget _buildChart(String title, Future<List<ExpenseModel>> expenses, ChartType chartType) {
    return FutureBuilder<List<ExpenseModel>>(
      future: expenses,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<ExpenseModel> expenseData = snapshot.data!;
          switch (chartType) {
            case ChartType.PieChart:
              return _buildPieChart(title, expenseData);
            case ChartType.BarChart:
              return _buildBarChart(title, expenseData);
          }
        }
      },
    );
  }

  Widget _buildPieChart(String title, List<ExpenseModel> expenses) {
    List<ExpensePieChartModel> pieChartData = _calculatePieChartData(expenses);

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '$title Expenses',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: PieChart(
              PieChartData(
                sections: _buildPieChartData(pieChartData),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<ExpensePieChartModel> _calculatePieChartData(List<ExpenseModel> expenses) {
    Map<String, double> cropExpenses = {};
    for (var expense in expenses) {
      cropExpenses.update(expense.expenseType, (value) => value + expense.amount, ifAbsent: () => expense.amount);
    }

    List<ExpensePieChartModel> pieChartData = [];
    cropExpenses.forEach((cropName, totalAmount) {
      pieChartData.add(ExpensePieChartModel(cropName: cropName, totalAmountSpent: totalAmount));
    });

    return pieChartData;
  }

  List<PieChartSectionData> _buildPieChartData(List<ExpensePieChartModel> pieChartData) {
    List<PieChartSectionData> pieChartSections = [];
    for (var data in pieChartData) {
      pieChartSections.add(
        PieChartSectionData(
          value: data.totalAmountSpent,
          title: '\$${data.totalAmountSpent.toStringAsFixed(2)}',
          radius: 100,
          titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      );
    }

    return pieChartSections;
  }

  Widget _buildBarChart(String title, List<ExpenseModel> expenses) {
    List<ExpenseBarChartModel> barChartData = _calculateBarChartData(expenses);

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '$title Expenses',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: BarChart(
              BarChartData(
                barGroups: _buildBarChartData(barChartData),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<ExpenseBarChartModel> _calculateBarChartData(List<ExpenseModel> expenses) {
    Map<String, double> monthExpenses = {};
    for (var expense in expenses) {
      String monthName = '${expense.expenseDate.month}-${expense.expenseDate.year}';
      monthExpenses.update(monthName, (value) => value + expense.amount, ifAbsent: () => expense.amount);
    }

    List<ExpenseBarChartModel> barChartData = [];
    monthExpenses.forEach((monthName, totalAmount) {
      barChartData.add(ExpenseBarChartModel(monthName: monthName, totalAmount: totalAmount));
    });

    return barChartData;
  }

  List<BarChartGroupData> _buildBarChartData(List<ExpenseBarChartModel> barChartData) {
    List<BarChartGroupData> barChartGroups = [];
    int x = 0;

    for (var data in barChartData) {
      barChartGroups.add(
        BarChartGroupData(
          x: x,
          barRods: [
            BarChartRodData(
              fromY: data.totalAmount,
              color: Colors.blue,
              width: 20, toY: 0.0,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
      );
      x++;
    }

    return barChartGroups;
  }
}

enum ChartType {
  PieChart,
  BarChart,
}
