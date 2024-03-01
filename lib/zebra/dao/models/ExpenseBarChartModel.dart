class ExpenseBarChartModel {
  final String monthYear;
  final double totalAmount;

  ExpenseBarChartModel({
    required this.monthYear,
    required this.totalAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'monthYear': this.monthYear,
      'totalAmount': this.totalAmount,
    };
  }

  factory ExpenseBarChartModel.fromMap(Map<String, dynamic> map) {
    return ExpenseBarChartModel(
      monthYear: map['monthYear'] as String,
      totalAmount: map['totalAmount'] as double,
    );
  }
}
