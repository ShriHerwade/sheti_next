import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sheti_next/zebra/dao/models/ExpenseModel.dart';
import 'package:sheti_next/zebra/dao/models/ExpensePieChartModel.dart';
import 'package:sheti_next/zebra/dao/models/ExpenseBarChartModel.dart';
import 'package:sheti_next/zebra/dao/models/ViewExpenseModel.dart';
import 'package:sheti_next/zebra/screen/farming/DashboardScreen.dart';
import 'package:sheti_next/zebra/screen/farming/FarmWisePiechart.dart';
import 'package:sheti_next/zebra/screen/farming/PaiChart2.dart';
import 'package:sheti_next/zebra/screen/farming/Paichart.dart';
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
         //MyPieChartWidget(),
          DashboardScreen(),
          MyPieChartWidget(),
          FarmWisePieChartWidget()
        ],
      ),
    );
  }

  }
