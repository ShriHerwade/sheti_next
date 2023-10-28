import 'package:flutter/material.dart';
class MyEvents extends StatefulWidget {
  const MyEvents({super.key});

  @override
  State<MyEvents> createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Events"),
      ),
      body: Center(
        child: Container(
          child: Text("This is My Events  Screen"),
        ),
      ),
    );
  }
}
