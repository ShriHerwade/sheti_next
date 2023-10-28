import 'package:flutter/material.dart';
class CreateFarms extends StatefulWidget {
  const CreateFarms({super.key});

  @override
  State<CreateFarms> createState() => _CreateFarmsState();
}

class _CreateFarmsState extends State<CreateFarms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create Farms"),
      ),
      body: Center(
        child: Container(
          child: Text("This is Create Farms Screen"),
        ),
      ),
    );
  }
}
