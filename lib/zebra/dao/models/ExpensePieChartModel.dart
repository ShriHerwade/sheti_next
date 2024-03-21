class ExpensePieChartModel {
  final String cropName;
  final String farmName;
  final double totalAmountSpent;

  ExpensePieChartModel({
    required this.cropName,
    required this.farmName,
    required this.totalAmountSpent,
  });

  Map<String, dynamic> toMap() {
    return {
      'cropName': this.cropName,
      'farmName':this .farmName,
      'totalAmountSpent': this.totalAmountSpent,
    };
  }

  factory ExpensePieChartModel.fromMap(Map<String, dynamic> map) {
    return ExpensePieChartModel(
      cropName: map['cropName'] as String,
      farmName: map['farmName'] as String,
      totalAmountSpent: map['totalAmountSpent'] as double,
    );
  }
}
