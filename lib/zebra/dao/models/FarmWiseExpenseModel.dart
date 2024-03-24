import 'package:sheti_next/zebra/dao/models/ExpenseModel.dart';

class FarmWiseExpenseModel {
  String farmName;
  final Map<String, List<ExpenseModel>> cropExpensesMap;

  FarmWiseExpenseModel({required this.farmName, required this.cropExpensesMap});

  Map<String, dynamic> toMap() {
    return {
      'farmName': this.farmName,
      'cropExpensesMap': this.cropExpensesMap,
    };
  }

  factory FarmWiseExpenseModel.fromMap(Map<String, dynamic> map) {
    return FarmWiseExpenseModel(
      farmName: map['farmName'] as String,
      cropExpensesMap: map['cropExpensesMap'] as Map<String, List<ExpenseModel>>,
    );
  }
}
