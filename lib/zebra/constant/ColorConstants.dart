import 'package:flutter/material.dart';

class ColorConstants {
  // Field border
  static const Color enabledFieldBorderColor = Colors.grey;
  static const Color disabledFieldBorderColor = Colors.grey;
  static const Color focusedFieldBorderColor = Colors.lightGreen;
  static const Color errorFieldBorderColor = Colors.redAccent;
  static const Color fieldFillDefaultColor = Colors.white;

  //Field hint & label
  static const Color fieldHintTextColor = Color(0xFF989898); //grey 700 hex(616161) // old 807f7f,989898
  static const Color fieldLabelTextColor = Color(0xFF616161);

  //App bar
  static const Color appBarBackgroundColor = Color(0xFF0cb053); //primary green, 0cb053 - little dark, 0ec45d - aero
  static const Color appBarTextColor = Colors.white;
  static const Color appBarIconColor = Colors.white;

  //Button
  static const Color textButtonSaveColor = Color(0xFF0cb053); //0cb053 - little dark, 0ec45d - aero
  static const Color textButtonSaveTextColor = Colors.white;

  //Bottom NavBar
  static const Color bottomNavBarTextColor = Colors.black;
  static const Color bottomNavBarSelectedIconColor = Colors.black;
  static const Color bottomNavBarSelectedTextColor = Colors.white;

  // SnackBar Colors
  static const Color snackBarBackgroundColor = Color(0xFF0e5f60); //secondary blue-black
  static const Color snackBarTextColor = Colors.white;
  static const Color snackBarErrorCircleColor = Color(0xFFEE4B2B); //Bright red
  static const Color snackBarSuccessCircleColor = Color(0xFF0ec45d);

  static const Color checkBoxColor = Colors.white;
  static const Color checkBoxActiveColor = Color(0xFF0ec45d);

  //Dialog Button
  static const Color dialogBoxButtonSaveColor = Color(0xFF0ec45d);
  static const Color dialogBoxButtonCancelColor = Color(0xFF0ec45d);

  //dropdown
  static const Color dropdownElementTextColor = Colors.black;

  //icon
  static const Color miniIconDefaultColor = Colors.white;

  //ListView
  static const Color listViewBackgroundColor = Color(0xFFF5F5F5); //grey 100
  static const Color listViewTitleTextColor = Colors.black;
  static const Color listViewSubTitleTextColor = Color(0xFF616161); //grey 700
  static const Color listViewChildTextColor = Color(0xFF616161); //grey 700
  static const Color listViewSurfaceTintColor = Color(0xFFF5F5F5); //grey 100


}
