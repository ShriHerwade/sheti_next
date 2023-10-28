import 'package:flutter/material.dart';
class CreateEvents extends StatefulWidget {
  const CreateEvents({super.key});

  @override
  State<CreateEvents> createState() => _CreateEventsState();
}

class _CreateEventsState extends State<CreateEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create Events "),
      ),
      body: Center(
        child: Container(
          child: Text("This is Create Event Screen"),
        ),
      ),
    );
  }
}
