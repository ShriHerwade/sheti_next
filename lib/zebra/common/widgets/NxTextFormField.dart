import 'package:flutter/material.dart';
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
      this.isEnable = true,
      this.setmaxLength});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(

        //textAlign: TextAlign.start,
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
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(width:1,color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(width: 1,color: Colors.lightGreen.shade400)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(width: 1,color: Colors.grey,)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(width: 1,color: Colors.grey)),
            //prefixIcon: Icon(icon),
            hintText: hintName,
            labelText: hintName,
            //isDense: true,
            fillColor: Colors.white,
            filled: true),
      ),
    );
  }
}
