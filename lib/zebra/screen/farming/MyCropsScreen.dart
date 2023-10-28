import 'package:flutter/material.dart';
class MyCrops extends StatefulWidget {
  const MyCrops({super.key});

  @override
  State<MyCrops> createState() => _MyCropsState();
}

class _MyCropsState extends State<MyCrops> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Crops"),
      ),
      body: Center(
        child: Container(
          child: Text("This is Crops Screen"),
        ),
      ),
    );
  }
}
