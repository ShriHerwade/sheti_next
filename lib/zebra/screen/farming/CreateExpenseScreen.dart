import 'package:flutter/material.dart';
class CreateExpenses extends StatefulWidget {
  const CreateExpenses({super.key});

  @override
  State<CreateExpenses> createState() => _CreateExpensesState();
}

class _CreateExpensesState extends State<CreateExpenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create Expenses"),
      ),
      body: Center(
        child: Container(
          child: Text("This is Create Expenses Screen"),
        ),
      ),
    );
  }
}
