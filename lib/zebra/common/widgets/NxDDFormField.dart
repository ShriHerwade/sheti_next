import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
class NxDDFormField extends StatefulWidget {
  final String? value;
  final String label;
  final List<String> items;
  final Function(String?) onChanged;

  const NxDDFormField({
    Key? key,
    required this.value,
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
    final dropdownStyle = TextStyle(
      fontSize: 16,
      color: Colors.black,
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
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
            label:Text(widget.label.tr())
          ),
          value: widget.value,
          hint: Text(widget.label.tr(), style: dropdownStyle),
          onChanged: widget.onChanged,
          items: widget.items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ),
    );
  }
}
