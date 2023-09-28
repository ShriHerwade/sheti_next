import 'package:flutter/material.dart';

class NxDropdown extends StatefulWidget {
  @override
  State<NxDropdown> createState() => _NxDropdownState();
}

class _NxDropdownState extends State<NxDropdown> {
  String selectOption = "Select option";
  String? selectedValue;
  List<String> NxdropDownItems = ['Wheat', 'Rice', 'Corn', 'Lintels'];

  // Color? NxboxColor;
  // Color? NxdropDownColor;
  // String? NxHintText;
  // bool NxIsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.greenAccent, width: 1),
            borderRadius: BorderRadius.circular(20.0)),
        child: Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: DropdownButtonFormField<String>(
            hint: Text(selectOption),
            value: selectedValue,
            borderRadius: BorderRadius.circular(20.0),
            dropdownColor: Colors.greenAccent,
            decoration:
                InputDecoration.collapsed(hintText: Text('').toString()),
            isExpanded: true,
            padding: EdgeInsets.all(10),
            items: NxdropDownItems.map((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedValue = newValue;
              });
            },
          ),
        ));
  }
}
