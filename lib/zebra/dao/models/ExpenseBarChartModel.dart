class ExpenseBarChartModel {
  final String monthName;
  final double totalAmount;

  ExpenseBarChartModel({
    required this.monthName,
    required this.totalAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'monthName': this.monthName,
      'totalAmount': this.totalAmount,
    };
  }

  factory ExpenseBarChartModel.fromMap(Map<String, dynamic> map) {
    return ExpenseBarChartModel(
      monthName: map['monthName'] as String,
      totalAmount: map['totalAmount'] as double,
    );
  }
}
