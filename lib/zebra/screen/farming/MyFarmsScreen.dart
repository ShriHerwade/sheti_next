import 'package:flutter/material.dart';
class MyFarms extends StatefulWidget {
  const MyFarms({super.key});

  @override
  State<MyFarms> createState() => _MyFarmsState();
}

class _MyFarmsState extends State<MyFarms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Farms"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Text("This is Farm Screen"),
        ),
      ),
    );
  }
}
