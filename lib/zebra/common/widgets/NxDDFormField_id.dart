import 'package:flutter/material.dart';

class NxDDFormField_id extends StatefulWidget {
  final int? selectedItemId;
  final String label;
  final String hint;
  final Map<int, String> items;
  final Function(int?) onChanged;

  const NxDDFormField_id({
    Key? key,
    required this.selectedItemId,
    required this.hint,
    required this.label,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<NxDDFormField_id> createState() => _NxDDFormField_idState();
}

class _NxDDFormField_idState extends State<NxDDFormField_id> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      height: 57,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<int>(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Colors.lightGreen.shade400),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            fillColor: Colors.white,
            filled: true,
            labelText: widget.selectedItemId != null ? widget.label : null,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            isDense: true,
          ),
          hint: Text(widget.hint, style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal)),
          value: widget.selectedItemId,
          onChanged: widget.onChanged,
          items: widget.items.keys.map((int itemId) {
            return DropdownMenuItem<int>(
              value: itemId,
              child: Text(widget.items[itemId]!, style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black)),
            );
          }).toList(),
        ),
      ),
    );
  }
}