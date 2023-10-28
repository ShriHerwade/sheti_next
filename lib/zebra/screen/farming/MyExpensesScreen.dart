import 'package:flutter/material.dart';
class MyExpenses extends StatefulWidget {
  const MyExpenses({super.key});

  @override
  State<MyExpenses> createState() => _MyExpensesState();
}

class _MyExpensesState extends State<MyExpenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Expenses"),
      ),
      body: Center(
        child: Container(
          child: Text("This is My Expenses Screen"),
        ),
      ),
    );
  }
}
