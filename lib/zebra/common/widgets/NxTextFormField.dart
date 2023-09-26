import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/common/widgets/NxAlert.dart';

import '../util/InputValidator.dart';

class NxTextFormField extends StatelessWidget {
  TextEditingController? controller;
  String? hintName;
  IconData? icon;
  bool isObsecureText;
  TextInputType inputType;
  bool isEnable;
  int? setmaxLength;


  NxTextFormField(
      {this.controller,
      this.hintName,
      this.icon,
      this.isObsecureText = false,
      this.inputType = TextInputType.text,
      this.isEnable = true,this.setmaxLength});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: controller,
        obscureText: isObsecureText,
        keyboardType: inputType,
        enabled: isEnable,
        maxLength: setmaxLength,

        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please Enter $hintName";
          }
          if (hintName == "Email" && !validateEmail(value)) {
            return "Please Enter valid Email Address";
          }
          return null;
        },
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(color: Colors.transparent)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(color: Colors.blue)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(color: Colors.grey)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(color: Colors.grey)),
            prefixIcon: Icon(icon),
            hintText: hintName,
           // labelText: hintName,
            fillColor: Colors.grey[200],
            filled: true),
      ),
    );
  }
}
