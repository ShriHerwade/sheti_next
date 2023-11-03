import 'package:flutter/material.dart';

class NxDDFormField extends StatefulWidget {
  final List<String> options;
  final String value;
  final ValueChanged<String> onChanged;
  String label="";

  NxDDFormField({
    required this.options,
    required this.value,
    required this.onChanged,
    //this.label,
  });

  @override
  _NxDDFormFieldState createState() => _NxDDFormFieldState();
}

class _NxDDFormFieldState extends State<NxDDFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Text(
            widget.label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          DropdownButtonFormField<String>(
            value: widget.value,
            items: widget.options.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                widget.onChanged(newValue);
              }
            },
      decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
      borderSide: BorderSide(color: Colors.transparent)),
      focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
      borderSide: BorderSide(color: Colors.blue)),
      disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
      borderSide: BorderSide(color: Colors.grey)),
      errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
      borderSide: BorderSide(color: Colors.grey)),
   // prefixIcon: Icon(icon),
      //hintText: hintName,
      // labelText: hintName,
      fillColor: Colors.grey[200],
      filled: true),
            ),
        ],
      ),
    );
  }
}
