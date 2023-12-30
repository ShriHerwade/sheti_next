import 'package:flutter/material.dart';

class NxDDFormField extends StatefulWidget {
  final String? selectedKey; // Change to selectedKey
  final String label;
  final String hint;
  final Map<String, String> items; // Change to Map<String, String>
  final Function(String?) onChanged;

  const NxDDFormField({
    Key? key,
    required this.selectedKey,
    required this.hint,
    required this.label,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<NxDDFormField> createState() => _NxDDFormFieldState();
}

class _NxDDFormFieldState extends State<NxDDFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      height: 57,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
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
            labelText: widget.selectedKey != null && widget.selectedKey!.isNotEmpty
                ? widget.label
                : null,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            isDense: true,
          ),
          hint: Text(widget.hint, style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal)),
          value: widget.items[widget.selectedKey!], // Use selectedKey to get the corresponding value
          onChanged: widget.onChanged,
          items: widget.items.keys.map((String key) {
            return DropdownMenuItem<String>(
              value: widget.items[key],
              child: Text(widget.items[key]!, style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
