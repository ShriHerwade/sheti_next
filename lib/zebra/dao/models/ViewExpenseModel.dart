import 'package:path/path.dart';

class ViewExpenseModel {
  final int farmId;
  final String farmName;
  final int cropId;
  final String cropName;
  final int expenseId;
  final String expenseType;
  final DateTime expenseDate;
  final double amount;

  ViewExpenseModel({
    required this.farmId,
    required this.farmName,
    required this.cropId,
    required this.cropName,
    required this.expenseId,
    required this.expenseType,
    required this.expenseDate,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'farmId': this.farmId,
      'farmName': this.farmName,
      'cropId': this.cropId,
      'cropName': this.cropName,
      'expenseId': this.expenseId,
      'expenseType': this.expenseType,
      'expenseDate': this.expenseDate,
      'amount': this.amount,
    };
  }

  factory ViewExpenseModel.fromMap(Map<String, dynamic> map) {
    return ViewExpenseModel(
      farmId: map['farmId'] as int,
      farmName: map['farmName'] as String,
      cropId: map['cropId'] as int,
      cropName: map['cropName'] as String,
      expenseId: map['expenseId'] as int,
      expenseType: map['expenseType'] as String,
      expenseDate: map['expenseDate'] as DateTime,
      amount: map['amount'] as double,
    );
  }
}