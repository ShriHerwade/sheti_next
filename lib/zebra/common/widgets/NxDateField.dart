import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';

class NxDateField extends StatefulWidget {
  final String label;
  final String labelText;
  final String hintText;
  final DateTime? selectedDate;
  final Function(DateTime?) onTap;

  const NxDateField({
    Key? key,
    required this.label,
    required this.labelText,
    required this.hintText,
    required this.selectedDate,
    required this.onTap,
  }) : super(key: key);

  @override
  _NxDateFieldState createState() => _NxDateFieldState();
}

class _NxDateFieldState extends State<NxDateField> {
  final FocusNode _focusNode = FocusNode();
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = formatDate(widget.selectedDate);
    _textEditingController.addListener(_onTextChanged);

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    // Handle text changes
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        onTap: () {
          _selectDate(context);
        },
        child: Focus(
          focusNode: _focusNode,
          child: TextFormField(
            readOnly: true,
            onTap: () {
              _selectDate(context); // Open date picker on text field tap
            },
            controller: _textEditingController,
            decoration: InputDecoration(
              enabledBorder: _getOutlineInputBorder(
                  ColorConstants.enabledFieldBorderColor),
              focusedBorder: _getOutlineInputBorder(_focusNode.hasFocus
                  ? Colors.lightGreen
                  : ColorConstants.enabledFieldBorderColor),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              hintText: widget.selectedDate != null
                  ? formatDate(widget.selectedDate!)
                  : '${widget.hintText}',
              hintStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: ColorConstants.fieldHintTextColor),
              labelText: _textEditingController.text.isNotEmpty ? widget.labelText : null,

              labelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: ColorConstants.fieldLabelTextColor),
              suffixIcon: Icon(Icons.calendar_today),
              border: InputBorder.none,
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
