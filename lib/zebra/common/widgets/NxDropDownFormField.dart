import 'package:flutter/material.dart';

class NxDDFormField extends StatefulWidget {
  final List<String> options;
  final String value;
  final ValueChanged<String> onChanged;
  final String? label;
  final String? hint;
  final String selectOptionText;

  NxDDFormField({
    required this.options,
    required this.value,
    required this.onChanged,
    this.label,
    this.hint,
    this.selectOptionText= 'Select an option',
  });

  @override
  _NxDDFormFieldState createState() => _NxDDFormFieldState();
}

class _NxDDFormFieldState extends State<NxDDFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding :EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(

        children: <Widget>[
         /* Text(
            widget.label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),*/
         // SizedBox(height: 10.0),
          DropdownButtonFormField<String>(

            value: widget.value.isEmpty ? '' : widget.value,
            items: _getDropdownItems(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                widget.onChanged(newValue);
              }
            },
            decoration: InputDecoration(
                hintText: widget.selectOptionText,
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
                //prefixIcon: Icon(icon),
                //hintText: hintName,
                // labelText: hintName,
                fillColor: Colors.grey[200],
                filled: true),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _getDropdownItems() {
    List<DropdownMenuItem<String>> items = [
      DropdownMenuItem(
        value: '',
        child: Text(widget.selectOptionText),
      ),
    ];

    items.addAll(widget.options.map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList());
    return items;
  }
}



