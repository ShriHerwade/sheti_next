import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';
import '../util/InputValidator.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';

class NxTextFormField extends StatelessWidget {
  TextEditingController? controller;
  String? hintName;
  IconData? icon;
  bool isObsecureText;
  TextInputType inputType;
  bool isEnable;
  int? maxLength;
  int? maxLines;
  bool expands;

  NxTextFormField({
    this.controller,
    this.hintName,
    this.icon,
    this.isObsecureText = false,
    this.inputType = TextInputType.text,
    this.isEnable = true,
    this.maxLength,
    this.maxLines,
    this.expands = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: controller,
        obscureText: isObsecureText,
        keyboardType: inputType,
        enabled: isEnable,
        maxLength: maxLength,
        maxLines: expands ? null : maxLines,
        expands: expands,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please Enter $hintName";
          }
          if (hintName == "Email" && !validateEmail(value)) {
            return "Please Enter a valid Email Address";
          }
          return null;
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(width: 1, color: ColorConstants.enabledFieldBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(width: 1, color: ColorConstants.focusedFieldBorderColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(width: 1, color: ColorConstants.disabledFieldBorderColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(width: 1, color: ColorConstants.errorFieldBorderColor),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintText: hintName,
          hintStyle: TextStyle(fontWeight: FontWeight.normal, color: ColorConstants.fieldHintTextColor),
          labelText: hintName,
          labelStyle: TextStyle(fontWeight: FontWeight.normal, color: ColorConstants.fieldLabelTextColor),
          isDense: true,
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }
}
