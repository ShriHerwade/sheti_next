import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';

class NxDDFormField_id extends StatefulWidget {
  final int? selectedItemId;
  final String label;
  final String hint;
  final Map<int, String> items;
  final bool isMandatory;
  final bool isError;
  final Function(int?) onChanged;
  final EdgeInsetsGeometry padding;

  const NxDDFormField_id({
    Key? key,
    required this.selectedItemId,
    required this.hint,
    required this.label,
    required this.items,
    required this.onChanged,
    this.isMandatory = true,
    this.isError = false,
    this.padding =
        const EdgeInsets.symmetric(horizontal: 20.0), // Default padding
  }) : super(key: key);

  @override
  State<NxDDFormField_id> createState() => _NxDDFormField_idState();
}

class _NxDDFormField_idState extends State<NxDDFormField_id> {
  bool? _isError;

  String? validateInput(int? value) {
    if (widget.isMandatory) {
      if (value == null) {
        setState(() {
          _isError = _isError == null ? null : true;
        });
        return "Please Select ${widget.label}";
      } else {
        setState(() {
          _isError = _isError == null ? null : false;
        });
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      height: 57,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<int>(
          validator: validateInput,
          decoration: InputDecoration(
            errorStyle: TextStyle(height: 0, fontSize: 0.1),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                width: 1,
                color: _isError == true
                    ? ColorConstants.errorFieldBorderColor
                    : ColorConstants.enabledFieldBorderColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                width: 1,
                color: _isError == true
                    ? ColorConstants
                        .errorFieldBorderColor // Maintain the error border color for focused state
                    : ColorConstants.focusedFieldBorderColor,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                width: 1,
                color: ColorConstants.disabledFieldBorderColor,
              ),
            ),
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
                color: ColorConstants.errorFieldBorderColor,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
            labelText: widget.selectedItemId != null ? widget.label : null,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            isDense: true,
          ),
          hint: Text(
            widget.hint,
            style: TextStyle(
              color: ColorConstants.fieldHintTextColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          value: widget.selectedItemId,
          onChanged: widget.onChanged,
          items: widget.items.keys.map((int itemId) {
            return DropdownMenuItem<int>(
              value: itemId,
              child: Text(
                widget.items[itemId]!,
                style: TextStyle(
                  color: ColorConstants.dropdownElementTextColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
