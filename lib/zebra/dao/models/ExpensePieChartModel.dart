class ExpensePieChartModel {
  final String cropName;
  final double totalAmountSpent;

  ExpensePieChartModel({
    required this.cropName,
    required this.totalAmountSpent,
  });

  Map<String, dynamic> toMap() {
    return {
      'cropName': this.cropName,
      'totalAmountSpent': this.totalAmountSpent,
    };
  }

  factory ExpensePieChartModel.fromMap(Map<String, dynamic> map) {
    return ExpensePieChartModel(
      cropName: map['cropName'] as String,
      totalAmountSpent: map['totalAmountSpent'] as double,
    );
  }
}
