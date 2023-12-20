class ExpenseModel {
  final String farmName;
  final String cropName;
  final String expenseType;
  final double amount;
  final DateTime expenseDate;
  final bool isActive;
  final DateTime? createdDate;

  ExpenseModel( {
    required this.farmName,
    required this.cropName,
    required this.expenseType,
    required this.amount,
    required this.expenseDate,
    this.isActive = true,
    this.createdDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'farmName': farmName,
      'cropName': cropName,
      'expenseType': expenseType,
      'amount': amount,
      'expenseDate': expenseDate.toIso8601String(),
      'isActive': isActive ? 1 : 0,
      'createdDate': createdDate?.toIso8601String(),
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      farmName: map['farmName'],
      cropName: map['cropName'],
      expenseType: map['expenseType'],
      amount: map['amount'],
      expenseDate: DateTime.parse(map['expenseDate']),
      isActive: map['isActive'] == 1,
      createdDate: DateTime.parse(map['createdDate']),
    );
  }
}
