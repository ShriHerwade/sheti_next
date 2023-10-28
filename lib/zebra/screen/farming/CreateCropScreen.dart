import 'package:flutter/material.dart';
class CreateCrop extends StatefulWidget {
  const CreateCrop({super.key});

  @override
  State<CreateCrop> createState() => _CreateCropState();
}

class _CreateCropState extends State<CreateCrop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create Crops"),
      ),
      body: Center(
        child: Container(
          child: Text("This is Create Crops Screen"),
        ),
      ),
    );
  }
}
