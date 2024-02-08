import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';
import '../util/InputValidator.dart';

class NxTextFormField_NP extends StatefulWidget {
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

  const NxTextFormField_NP({
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
  }) : super(key: key);

  @override
  _NxTextFormField_NPState createState() => _NxTextFormField_NPState();
}

class _NxTextFormField_NPState extends State<NxTextFormField_NP> {
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
    if (value == null || value.isEmpty) {
      return "Please Enter ${widget.hintText}";
    }
    if (widget.hintText == "Email" && !validateEmail(value)) {
      return "Please Enter a valid Email Address";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
     padding: EdgeInsets.only(left:  20.0),
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
          labelText: _customTextFieldController.text.isNotEmpty ? widget.labelText : null,
          labelStyle: TextStyle(fontWeight: FontWeight.normal, color: ColorConstants.fieldLabelTextColor),
          isDense: true,
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }
}
