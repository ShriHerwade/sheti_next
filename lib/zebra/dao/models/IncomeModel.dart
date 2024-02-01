//ExpenseModel.dart
class IncomeModel {
  int? incomeId;
  int farmId;
  int cropId;
  int userId;
  double quantity;
  String unit;
  double? ratePerUnit;
  String? rateUnit;
  String? buyersName;
  String? receiptNumber;
  String? receiptFilePath;
  String? fileExtension;

  String? notes;
  final String incomeType;
  final double amount;
  final DateTime incomeDate;
  bool isActive;
  final DateTime? createdDate;

  IncomeModel(
      {this.incomeId,
      required this.farmId,
      required this.cropId,
      required this.userId,
      required this.quantity,
      required this.unit,
      this.ratePerUnit,
      this.rateUnit,
      this.buyersName,
      this.receiptNumber,
      this.receiptFilePath,
      this.fileExtension,
      this.notes,
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
      'buyersName': this.buyersName,
      'receiptNumber': this.receiptNumber,
      'receiptFilePath': this.receiptFilePath,
      'fileExtension': this.fileExtension,
      'notes': this.notes,
      'incomeType': this.incomeType,
      'amount': this.amount,
      'incomeDate': this.incomeDate?.toIso8601String(),
      'isActive': isActive ? 1 : 0,
      'createdDate': createdDate?.toIso8601String(),
    };
  }

  factory IncomeModel.fromMap(Map<String, dynamic> map) {
    return IncomeModel(
      incomeId: map['incomeId'],
      farmId: map['farmId'],
      cropId: map['cropId'],
      userId: map['userId'],
      quantity: map['quantity'],
      unit : map['unit'],
      ratePerUnit: map['ratePerUnit'],
      rateUnit: map['rateUnit'],
      buyersName: map['buyersName'],
      receiptNumber: map['receiptNumber'],
      receiptFilePath: map['receiptFilePath'],
      fileExtension: map['fileExtension'],
      notes: map['notes'],
      incomeType: map['incomeType'],
      amount: (map['amount'] as num).toDouble(),
      incomeDate: DateTime.parse(map['incomeDate']),
      isActive: map['isActive'] == 1,
      createdDate: DateTime.parse(map['createdDate']),
    );
  }
}
