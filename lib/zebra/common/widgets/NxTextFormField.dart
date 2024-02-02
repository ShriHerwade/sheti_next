import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';
import '../util/InputValidator.dart';

class NxTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final IconData? icon;
  final bool isObsecureText;
  final TextInputType inputType;
  final bool isEnable;
  final int? maxLength;
  final int? maxLines;
  final bool expands;

  NxTextFormField({
    this.controller,
    this.hintText,
    this.labelText,
    this.icon,
    this.isObsecureText = false,
    this.inputType = TextInputType.text,
    this.isEnable = true,
    this.maxLength,
    this.maxLines,
    this.expands = false,
  });

  @override
  _NxTextFormFieldState createState() => _NxTextFormFieldState();
}

class _NxTextFormFieldState extends State<NxTextFormField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        focusNode: _focusNode,
        controller: widget.controller,
        obscureText: widget.isObsecureText,
        keyboardType: widget.inputType,
        enabled: widget.isEnable,
        maxLength: widget.maxLength,
        maxLines: widget.expands ? null : widget.maxLines,
        expands: widget.expands,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please Enter ${widget.hintText}";
          }
          if (widget.hintText == "Email" && !validateEmail(value)) {
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
          hintText: widget.hintText,
          hintStyle: TextStyle(fontWeight: FontWeight.normal, color: ColorConstants.fieldHintTextColor),
          labelText: _focusNode.hasFocus || widget.controller?.text.isNotEmpty == true ? widget.labelText : null, // to stop  label overriding the hint
          labelStyle: TextStyle(fontWeight: FontWeight.normal, color: ColorConstants.fieldLabelTextColor),
          isDense: true,
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }
}
