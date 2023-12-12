import 'package:flutter/material.dart';
import '../util/InputValidator.dart';

// Custom TextFormField widget with specific styling and validation.
class NxTextFormField extends StatelessWidget {
  // Declare final fields for immutability.
  final TextEditingController? controller;
  final String? hintName;
  final IconData? icon;
  final bool isObsecureText;
  final TextInputType inputType;
  final bool isEnable;
  final int? setMaxLength;

  // Constructor with named parameters.
  NxTextFormField({
    this.controller,
    this.hintName,
    this.icon,
    this.isObsecureText = false,
    this.inputType = TextInputType.text,
    this.isEnable = true,
    this.setMaxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        textAlign: TextAlign.start,
        controller: controller,
        obscureText: isObsecureText,
        keyboardType: inputType,
        enabled: isEnable,
        maxLength: setMaxLength,
        // Validator function for input validation.
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please Enter $hintName";
          }
          if (hintName == "Email" && !validateEmail(value)) {
            return "Please Enter valid Email Address";
          }
          return null; // Return null for valid input.
        },
        // Styling and decoration of the TextFormField.
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(width: 1, color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(width: 1, color: Colors.lightGreen.shade400),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(width: 1, color: Colors.grey),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(width: 1, color: Colors.grey),
          ),
          prefixIcon: Icon(icon),
          hintText: hintName,
          isDense: true,
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }
}
