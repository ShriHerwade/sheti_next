class CropModel {
  final String farmName;
  final String cropName;
  final double area;
  final DateTime startDate;
  final DateTime endDate;

  CropModel({
    required this.farmName,
    required this.cropName,
    required this.area,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'farmName': farmName,
      'cropName': cropName,
      'area': area,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }

  factory CropModel.fromMap(Map<String, dynamic> map) {
    return CropModel(
      farmName: map['farmName'],
      cropName: map['cropName'],
      area: map['area'],
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
    );
  }
}
