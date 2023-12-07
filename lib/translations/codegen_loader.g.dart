// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "appTitle": "ShetiNext",
  "dashboard": "Dashboard",
  "createFarm": "Create New Farm",
  "createCrop": "Create New Crop",
  "createEvent": "Create New Event",
  "createExpense": "Create New Expense",
  "save": "Save",
  "cancel": "Cancel"
};
static const Map<String,dynamic> ka = {
  "appTitle": "ಶೆಟಿನೆಕ್ಸ್ಟ್",
  "dashboard": "ಡ್ಯಾಶ್ಬೋರ್ಡ್",
  "createFarm": "ಫಾರ್ಮ್ ರಚಿಸಿ"
};
static const Map<String,dynamic> mr = {
  "appTitle": "शेतीनेक्स्ट",
  "dashboard": "डॅशबोर्ड",
  "createFarm": "नवीन शेती तयार करा",
  "createCrop": "नवीन पीक तयार करा",
  "createEvent": "नवीन इव्हेंट तयार करा",
  "createExpense": "नवीन जमा -खर्च तयार करा",
  "save": "जतन करा",
  "cancel": "रद्द करा"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ka": ka, "mr": mr};
}
