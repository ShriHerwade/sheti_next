import 'package:flutter/material.dart';

class CreateIncomeScreen extends StatefulWidget {
  @override
  State<CreateIncomeScreen> createState() => _CreateIncomeScreenState();
}

class _CreateIncomeScreenState extends State<CreateIncomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Income Screen'),

      ),
      body: Center(
        child: Text("This is Create Income Screen"),
      )
    );
  }
}




