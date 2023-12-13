// date_field.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NxDateField extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final bool isStartDate;
  final Function(DateTime?) onTap;

  const NxDateField({
    Key? key,
    required this.label,
    required this.selectedDate,
    required this.isStartDate,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        readOnly: true,
        onTap: () => onTap(selectedDate),
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
          hintText: selectedDate != null ? formatDate(selectedDate) : '$label',
          suffixIcon: Icon(Icons.calendar_today),
          border: InputBorder.none,
        ),
        controller: TextEditingController(
          text: formatDate(selectedDate),
        ),
      ),
    );
  }

  String formatDate(DateTime? date) {
    if (date != null) {
      return DateFormat('dd/MM/yyyy').format(date);
    } else {
      return '';
    }
  }
}
