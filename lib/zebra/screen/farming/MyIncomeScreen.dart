import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyIncomePage(),
  ));
}

class MyIncomePage extends StatefulWidget {
  @override
  State<MyIncomePage> createState() => _MyIncomePageState();
}

class _MyIncomePageState extends State<MyIncomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Income Page'),
      ),*/
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'This is the MY Income Page',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
