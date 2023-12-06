class CropModel {
  final String farmName;
  final String cropName;
  final double area;
  final DateTime startDate;
  final DateTime endDate;
  bool isActive;
  DateTime? createdDate;

  CropModel({
    required this.farmName,
    required this.cropName,
    required this.area,
    required this.startDate,
    required this.endDate,
    this.isActive = true,
    this.createdDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'farmName': farmName,
      'cropName': cropName,
      'area': area,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'isActive': isActive ? 1 : 0,
      'createdDate': createdDate?.toIso8601String(),
    };
  }

  factory CropModel.fromMap(Map<String, dynamic> map) {
    return CropModel(
      farmName: map['farmName'],
      cropName: map['cropName'],
      area: map['area'],
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      isActive: map['isActive'] == 1,
      createdDate: DateTime.parse(map['createdDate']),
    );
  }
}
