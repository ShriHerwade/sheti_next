import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';

class NxDDFormField extends StatefulWidget {
  final bool isMandatory ;
  final String? Function(String?)? validator;
  final String? value;
  final String label;
  final String hint;
  final List<String> items;
  final Function(String?) onChanged;
  final EdgeInsetsGeometry padding; // New parameter for padding

  const NxDDFormField({
    Key? key,
    required this.value,
    required this.hint,
    required this.label,
    required this.items,
    required this.onChanged,
    this.isMandatory=true,
    this.validator,
    this.padding =
        const EdgeInsets.symmetric(horizontal: 20.0),  // Default padding
  }) : super(key: key);

  @override
  State<NxDDFormField> createState() => _NxDDFormFieldState();
}

class _NxDDFormFieldState extends State<NxDDFormField> {
  String? validateInput(String? value) {
    if(widget.isMandatory==true){
      if (value == null || value.isEmpty) {
        return "Please Enter ${widget.label}";
      }
      else
        {
          setState(() {

          });
          return null;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      height: 57,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          validator:validateInput ,

          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                  width: 1, color: ColorConstants.enabledFieldBorderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                  width: 1, color: ColorConstants.focusedFieldBorderColor),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                  width: 1, color: ColorConstants.disabledFieldBorderColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                  width: 1, color: ColorConstants.errorFieldBorderColor),
            ),
            focusedErrorBorder:OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                  width: 1, color: ColorConstants.enabledFieldBorderColor),
            ),
            fillColor: Colors.white,
            filled: true,
            labelText: widget.value != null && widget.value!.isNotEmpty
                ? widget.label
                : null,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            //isDense: true,
          ),
          hint: Text(
            widget.hint,
            style: TextStyle(
              color: ColorConstants.fieldHintTextColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          value: widget.value,
          onChanged: widget.onChanged,
          items: widget.items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: ColorConstants.dropdownElementTextColor,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
