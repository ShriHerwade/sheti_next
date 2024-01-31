//ExpenseModel.dart
class ExpenseModel {
  int? expenseId;
  int farmId;
  int cropId;
  int userId;
  bool? isFarmLevel;
  bool? isCredit;
  int? poeId;
  String? invoiceNumber;
  String? invoiceFilePath;
  String? fileExtension;
  int splitBetween;
  String? details;
  final String expenseType;
  final double amount;
  final DateTime expenseDate;
  bool isActive;
  final DateTime? createdDate;

  ExpenseModel(
      {this.expenseId,
      required this.farmId,
      required this.cropId,
      required this.userId,
      this.isFarmLevel,
      this.isCredit,
      this.poeId,
      this.invoiceNumber,
      this.invoiceFilePath,
      this.fileExtension,
      required this.splitBetween,
      this.details,
      required this.expenseType,
      required this.amount,
      required this.expenseDate,
      this.isActive = true,
      this.createdDate});

  Map<String, dynamic> toMap() {
    return {
      'expenseId': this.expenseId,
      'farmId': this.farmId,
      'cropId': this.cropId,
      'userId': this.userId,
      'isFarmLevel': this.isFarmLevel == true ? 1 : 0,
      'isCredit': this.isCredit== true ? 1 : 0,
      'poeId': this.poeId,
      'invoiceNumber': this.invoiceNumber,
      'invoiceFilePath': this.invoiceFilePath,
      'fileExtension': this.fileExtension,
      'splitBetween': this.splitBetween,
      'details': this.details,
      'expenseType': this.expenseType,
      'amount': this.amount,
      'expenseDate': this.expenseDate?.toIso8601String(),
      'isActive': isActive ? 1 : 0,
      'createdDate': createdDate?.toIso8601String(),
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      expenseId: map['expenseId'],
      farmId: map['farmId'],
      cropId: map['cropId'],
      userId: map['userId'],
      isFarmLevel: map['isFarmLevel'] == 1,
      isCredit: map['isCredit'] == 1,
      poeId: map['poeId'],
      invoiceNumber: map['invoiceNumber'],
      invoiceFilePath: map['invoiceFilePath'],
      fileExtension: map['fileExtension'],
      splitBetween: map['splitBetween'],
      details: map['details'],
      expenseType: map['expenseType'],
      amount: (map['amount'] as num).toDouble(),
      expenseDate: DateTime.parse(map['expenseDate']),
      isActive: map['isActive'] == 1,
      createdDate: DateTime.parse(map['createdDate']),
    );
  }
}
