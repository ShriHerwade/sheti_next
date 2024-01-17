// nx_date_field.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';

class NxDateField extends StatefulWidget {
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
  _NxDateFieldState createState() => _NxDateFieldState();
}

class _NxDateFieldState extends State<NxDateField> {
  final FocusNode _focusNode = FocusNode(); // Added FocusNode
  TextEditingController _textEditingController = TextEditingController();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _textEditingController.text = formatDate(widget.selectedDate);
    _textEditingController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _hasFocus = _textEditingController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        onTap: () {
          _selectDate(context);
          _focusNode.requestFocus(); // Request focus on tap
        },
        child: AbsorbPointer(
          child: Focus(
            focusNode: _focusNode, // Wrap TextFormField with Focus widget
            child: TextFormField(
              readOnly: true,
              controller: _textEditingController,
              decoration: InputDecoration(
                enabledBorder: _getOutlineInputBorder(ColorConstants.enabledFieldBorderColor),
                focusedBorder: _getOutlineInputBorder(_hasFocus ? Colors.lightGreen : ColorConstants.focusedFieldBorderColor),
                disabledBorder: _getOutlineInputBorder(ColorConstants.disabledFieldBorderColor),
                errorBorder: _getOutlineInputBorder(ColorConstants.errorFieldBorderColor),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                isDense: true,
                fillColor: ColorConstants.fieldFillDefaultColor,
                filled: true,
                hintText: widget.selectedDate != null ? formatDate(widget.selectedDate!) : '${widget.label}',
                hintStyle: TextStyle(fontWeight: FontWeight.normal, color: ColorConstants.fieldLabelTextColor),
                labelText: widget.labelText,
                labelStyle: TextStyle(fontWeight: FontWeight.normal, color: ColorConstants.fieldHintTextColor),
                suffixIcon: Icon(Icons.calendar_today),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      widget.onTap(picked);
      _textEditingController.text = formatDate(picked);
    }
  }

  String formatDate(DateTime? date) {
    if (date != null) {
      return DateFormat('dd/MM/yyyy').format(date);
    } else {
      return '';
    }
  }

  OutlineInputBorder _getOutlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(width: 1, color: color),
    );
  }
}
