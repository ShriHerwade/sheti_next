import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';
import '../util/InputValidator.dart';
validateEmail(String email) {
  final emailReg = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  return emailReg.hasMatch(email);
}
