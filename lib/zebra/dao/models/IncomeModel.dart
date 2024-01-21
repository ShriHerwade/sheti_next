//ExpenseModel.dart
class ExpenseModel {
  int? incomeId;
  int farmId;
  int cropId;
  int userId;
  double quantity;
  String unit;
  double? ratePerUnit;
  String? rateUnit;
  String? soldTo;
  String? receiptNumber;
  String? receiptFilePath;
  String? fileExtension;

  String? details;
  final String incomeType;
  final double amount;
  final DateTime incomeDate;
  bool isActive;
  final DateTime? createdDate;

  ExpenseModel(
      {this.incomeId,
      required this.farmId,
      required this.cropId,
      required this.userId,
      required this.quantity,
      required this.unit,
      this.ratePerUnit,
      this.rateUnit,
      this.soldTo,
      this.receiptNumber,
      this.receiptFilePath,
      this.fileExtension,
      this.details,
      required this.incomeType,
      required this.amount,
      required this.incomeDate,
      this.isActive = true,
      this.createdDate});

  Map<String, dynamic> toMap() {
    return {
      'incomeId': this.incomeId,
      'farmId': this.farmId,
      'cropId': this.cropId,
      'userId': this.userId,
      'quantity' : this.quantity,
      'unit' : this.unit,
      'ratePerUnit' : this.ratePerUnit,
      'rateUnit' : this.rateUnit,
      'soldTo': this.soldTo,
      'receiptNumber': this.receiptNumber,
      'receiptFilePath': this.receiptFilePath,
      'fileExtension': this.fileExtension,
      'details': this.details,
      'incomeType': this.incomeType,
      'amount': this.amount,
      'incomeDate': this.incomeDate?.toIso8601String(),
      'isActive': isActive ? 1 : 0,
      'createdDate': createdDate?.toIso8601String(),
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      incomeId: map['incomeId'],
      farmId: map['farmId'],
      cropId: map['cropId'],
      userId: map['userId'],
      quantity: map['quantity'],
      unit : map['unit'],
      ratePerUnit: map['ratePerUnit'],
      rateUnit: map['rateUnit'],
      soldTo: map['soldTo'],
      receiptNumber: map['receiptNumber'],
      receiptFilePath: map['receiptFilePath'],
      fileExtension: map['fileExtension'],
      details: map['details'],
      incomeType: map['incomeType'],
      amount: (map['amount'] as num).toDouble(),
      incomeDate: DateTime.parse(map['incomeDate']),
      isActive: map['isActive'] == 1,
      createdDate: DateTime.parse(map['createdDate']),
    );
  }
}
