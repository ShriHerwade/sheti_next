import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';
import '../util/InputValidator.dart';

class NxTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final IconData? icon;
  final bool isObsecureText;
  final bool isMandatory ;
  final TextInputType inputType;
  final bool isEnable;
  final int? maxLength;
  final int? maxLines;
  final bool expands;
  final EdgeInsetsGeometry padding;
  final String? Function(String?)? validator;
  const NxTextFormField({
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
    this.isMandatory=true,
    this.validator,
    this.padding =
        const EdgeInsets.symmetric(horizontal: 20.0),  // Default padding
  }) : super(key: key);

  @override
  _NxTextFormFieldState createState() => _NxTextFormFieldState();
}

class _NxTextFormFieldState extends State<NxTextFormField> {
  late TextEditingController _customTextFieldController;

  @override
  void initState() {
    super.initState();
    _customTextFieldController = widget.controller ?? TextEditingController();
    _customTextFieldController.addListener(updateState);
  }

  @override
  void dispose() {
    _customTextFieldController.removeListener(updateState);
    if (widget.controller == null) {
      _customTextFieldController.dispose();
    }
    super.dispose();
  }

  void updateState() {
    setState(() {});
  }

 String? validateInput(String? value) {
    if(widget.isMandatory==true){
      if (value == null || value.isEmpty) {
        return "Please Enter ${widget.labelText}";
      }
      if (widget.hintText == "Email" && !validateEmail(value)) {
        return "Please Enter a valid Email Address";
      }
      return null;
    }
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

       validator: validateInput,
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
              color: ColorConstants.fieldLabelTextColor),
          isDense: true,
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }
}
