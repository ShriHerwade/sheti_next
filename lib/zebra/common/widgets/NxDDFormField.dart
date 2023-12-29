import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NxDDFormField extends StatefulWidget {
  final String? value;
  final String label;
  final String hint;
  final List<String> items;
  final Function(String?) onChanged;

  const NxDDFormField({
    Key? key,
    required this.value,
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
            // Show label only if the dropdown is selected
            labelText: widget.value != null && widget.value!.isNotEmpty
                ? widget.label
                : null,
            //labelStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          ),
          hint: Text(widget.hint,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal)),
          value: widget.value,
          onChanged: widget.onChanged,
          items: widget.items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item,style: TextStyle(fontWeight: FontWeight.normal,color: Colors.black)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
