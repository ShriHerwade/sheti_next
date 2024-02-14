import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';
import 'package:sheti_next/zebra/constant/SizeConstants.dart';
import '../util/InputValidator.dart';

class NxTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final IconData? icon;
  final bool isObsecureText;
  final bool isMandatory;
  final TextInputType inputType;
  final bool isEnable;
  final bool isError;
  final int? maxLength;
  final int? maxLines;
  final bool expands;
  final EdgeInsetsGeometry padding;
  final String? Function(String?)? validator;

   NxTextFormField({
    Key? key,
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
    this.isMandatory = true,
    this.isError=false,
    this.validator,
    this.padding = const EdgeInsets.symmetric(horizontal: 20.0),
  }) : super(key: key);

  @override
  _NxTextFormFieldState createState() => _NxTextFormFieldState();
}

class _NxTextFormFieldState extends State<NxTextFormField> {
  late TextEditingController _customTextFieldController;
  bool? _isError;

  @override
  void initState() {
    super.initState();
    _customTextFieldController = widget.controller ?? TextEditingController();
    _isError= widget.isError;
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _customTextFieldController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      child: TextFormField(
        controller: _customTextFieldController,
        obscureText: widget.isObsecureText,
        keyboardType: widget.inputType,
        enabled: widget.isEnable,
        maxLength: widget.maxLength,
        maxLines: widget.expands ? null : widget.maxLines,
        expands: widget.expands,
        onChanged: (value) {
          setState(() {
            _isError = _isError == null ? null : false;
          });// Update the state to reflect changes
        },
        validator: (value) {
          if (widget.isMandatory && (value == null || value.isEmpty)) {
            setState(() {
              // Check for null before updating _isError
              _isError = _isError == null ? null : true;
            });
           return "Please Enter ${widget.labelText}";
          }
          if (widget.hintText == "Email" && !validateEmail(value!)) {
            setState(() {
              // Check for null before updating _isError
              _isError = _isError == null ? null : true;
            });
            return "Please Enter a valid Email Address";
          }
          return null;
        },
        decoration: InputDecoration(
          errorStyle: TextStyle(height: 0,fontSize: 0.1),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(
              width: 1, color: _isError! ? ColorConstants.errorFieldBorderColor : ColorConstants.enabledFieldBorderColor,

          ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(
              width: 1,color: ColorConstants.focusedFieldBorderColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(
              width: 1, color: ColorConstants.errorFieldBorderColor,
            ),
          ),
         focusedErrorBorder:  OutlineInputBorder(
           borderRadius: BorderRadius.all(Radius.circular(8.0)),
           borderSide: BorderSide(
             width: 1,color: ColorConstants.focusedFieldBorderColor,
           ),
         ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintText: widget.hintText,
          hintStyle: TextStyle(
              fontWeight: FontWeight.normal,
              color: ColorConstants.fieldHintTextColor),
          labelText: _customTextFieldController.text.isNotEmpty
              ? widget.labelText
              : null,
          labelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              color: ColorConstants.fieldLabelTextColor,
              fontSize: SizeConstants.floatingLabelFontSize),
          isDense: true,
          fillColor: Colors.white,
          filled: true,

        ),
      ),
    );
  }
}