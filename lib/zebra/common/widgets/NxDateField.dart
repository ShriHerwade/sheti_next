// nx_date_field.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';

class NxDateField extends StatelessWidget {
  final String label;
  final String labelText;
  final DateTime? selectedDate;
  final bool? isStartDate;
  final Function(DateTime?) onTap;

  const NxDateField({
    Key? key,
    required this.label,
    required this.labelText,
    required this.selectedDate,
    this.isStartDate, // Make isStartDate nullable
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
          child: TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(width:1,color: ColorConstants.enabledFieldBorderColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(width: 1,color: ColorConstants.focusedFieldBorderColor)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(width: 1,color: ColorConstants.disabledFieldBorderColor)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(width: 1,color: ColorConstants.errorFieldBorderColor)),

              isDense: true,
              fillColor: ColorConstants.fieldFillDefaultColor,
              filled: true,
              hintText: selectedDate != null ? formatDate(selectedDate!) : '$label',hintStyle: TextStyle(fontWeight: FontWeight.normal,color:ColorConstants.fieldHintTextColor),
              labelText: labelText,labelStyle: TextStyle(fontWeight: FontWeight.normal,color: ColorConstants.fieldLabelTextColor),
              suffixIcon: Icon(Icons.calendar_today),
              border: InputBorder.none,
            ),
            controller: TextEditingController(
              text: formatDate(selectedDate),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      onTap(picked);
    }
  }

  String formatDate(DateTime? date) {
    if (date != null) {
      return DateFormat('dd/MM/yyyy').format(date);
    } else {
      return '';
    }
  }
}
