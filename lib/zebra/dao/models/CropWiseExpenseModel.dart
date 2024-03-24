import 'package:sheti_next/zebra/dao/models/ExpenseModel.dart';

class CropWiseExpenseModel {
  String cropName;
  List<ExpenseModel> expenses;

  CropWiseExpenseModel({required this.cropName, required this.expenses});

  Map<String, dynamic> toMap() {
    return {

      'cropName': this.cropName,
      'expenses': this.expenses,
    };
  }

  factory CropWiseExpenseModel.fromMap(Map<String, dynamic> map) {
    return CropWiseExpenseModel(
      cropName: map['cropName'] as String,
      expenses: map['expenses'] as List<ExpenseModel>,
    );
  }
}
