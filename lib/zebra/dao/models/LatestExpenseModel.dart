import 'package:path/path.dart';

class LatestExpenseModel {
  final int farmId;
  final String farmName;
  final int cropId;
  final String cropName;
  final int expenseId;
  final String expenseType;
  final DateTime expenseDate;
  final double amount;

  LatestExpenseModel({
    required this.farmId,
    required this.farmName,
    required this.cropId,
    required this.cropName,
    required this.expenseId,
    required this.expenseType,
    required this.expenseDate,
    required this.amount,
  });
}