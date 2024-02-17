import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';
import 'package:sheti_next/zebra/constant/SizeConstants.dart';

class NxDateField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String labelText;
  final String hintText;
  final DateTime? selectedDate;
  final Function(DateTime?) onTap;
  final bool isMandatory;
  final bool isError;
  final EdgeInsetsGeometry padding;
  final String? Function(String?)? validator;

  const NxDateField({
    Key? key,
    required this.controller,
    required this.label,
    required this.labelText,
    required this.hintText,
    required this.selectedDate,
    required this.onTap,
    this.isMandatory = true,
    this.isError = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 20.0),
    this.validator,
  }) : super(key: key);

  @override
  _NxDateFieldState createState() => _NxDateFieldState();
}

class _NxDateFieldState extends State<NxDateField> {
  final FocusNode _focusNode = FocusNode();
  TextEditingController _textEditingController = TextEditingController();
  bool? _isError;

  @override
  void initState() {
    super.initState();
    _textEditingController.text = formatDate(widget.selectedDate);
    _textEditingController.addListener(_onTextChanged);
    _isError = widget.isError;
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
      padding: widget.padding,
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: Focus(
          focusNode: _focusNode,
          child: TextFormField(
            controller: widget.controller,
            readOnly: true,
            onTap: () {
              _selectDate(context);
              setState(() {
                _isError = _isError == null ? null : false;
              });// Open date picker on text field tap
            },
            validator: (value) {
              if (widget.isMandatory && (value == null || value.isEmpty)) {
                setState(() {
                  // Check for null before updating _isError
                  _isError = _isError == null ? null : true;
                });
                return "Please Enter ${widget.labelText}";
              }
              return null;
            },
            decoration: InputDecoration(
              errorStyle: TextStyle(height: 0, fontSize: 0.1),
              enabledBorder: _getOutlineInputBorder(
                  ColorConstants.enabledFieldBorderColor),
              focusedBorder: _getOutlineInputBorder(_focusNode.hasFocus
                  ? Colors.lightGreen
                  : ColorConstants.enabledFieldBorderColor),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstants.errorFieldBorderColor,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstants.focusedFieldBorderColor,
                ),
              ),
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
              labelText: _textEditingController.text.isNotEmpty
                  ? widget.labelText
                  : null,
              labelStyle: TextStyle(
                fontWeight: FontWeight.normal,
                color: ColorConstants.fieldLabelTextColor,
                fontSize: SizeConstants.floatingLabelFontSize,
              ),
              suffixIcon: Icon(Icons.calendar_today),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _getOutlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(width: 1, color: color),
    );
  }

  String formatDate(DateTime? date) {
    if (date != null) {
      return DateFormat('dd/MM/yyyy').format(date);
    } else {
      return '';
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      widget.onTap(pickedDate);
      setState(() {
        widget.controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }
}
