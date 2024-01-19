import 'package:flutter/material.dart';


class IncomeExpenseAnalyser extends StatefulWidget {
  @override
  State<IncomeExpenseAnalyser> createState() => _IncomeExpenseAnalyserState();
}

class _IncomeExpenseAnalyserState extends State<IncomeExpenseAnalyser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Income/ Expenses Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'This is the Income  & Expenditure Page',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
