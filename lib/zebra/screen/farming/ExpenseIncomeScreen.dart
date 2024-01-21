import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/screen/farming/CreateExpenseScreen.dart';
import 'package:sheti_next/zebra/screen/farming/CreateIncomeScreen.dart';

class ExpenseIncomeScreen extends StatefulWidget {
  @override
  State<ExpenseIncomeScreen> createState() => _ExpenseIncomeScreenState();
}

class _ExpenseIncomeScreenState extends State<ExpenseIncomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Income/Expenses Page'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(child: Text("Create Expense", style: TextStyle(color: Colors.white))),
            Tab(child: Text("Create Income", style: TextStyle(color: Colors.white))),
          ],
        ),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            // Swipe from left to right
            _tabController.animateTo(_tabController.index - 1);
          } else if (details.primaryVelocity! < 0) {
            // Swipe from right to left
            _tabController.animateTo(_tabController.index + 1);
          }
        },
        child: TabBarView(
          controller: _tabController,
          children: [
            CreateExpenses(),
            CreateIncomeScreen(),
          ],
        ),
      ),
    );
  }
}
