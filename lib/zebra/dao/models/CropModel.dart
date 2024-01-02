import 'dart:core';
class CropModel {
  int? cropId;
  int farmId;
  final String cropName;
  final String cropVariety;
  final double area;
  final String unit;
  final DateTime startDate;
  final DateTime endDate;
  bool isActive;
  DateTime? createdDate;

  CropModel({
    this.cropId,
    required this.farmId,
    required this.cropName,
    required this.cropVariety,
    required this.area,
    required this.unit,
    required this.startDate,
    required this.endDate,
    this.isActive = true,
    this.createdDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'cropId': this.cropId,
      'farmId': this.farmId,
      'cropName': this.cropName,
      'cropVariety': this.cropVariety,
      'area': this.area,
      'unit': this.unit,
      'startDate': this.startDate?.toIso8601String(),
      'endDate': this.endDate?.toIso8601String(),
      'isActive': isActive ? 1 : 0,
      'createdDate': createdDate?.toIso8601String(),
    };
  }

  factory CropModel.fromMap(Map<String, dynamic> map) {
    return CropModel(
      cropId: map['cropId'],
      farmId: map['farmId'],
      cropName: map['cropName'],
      cropVariety: map['cropVariety'],
      area: map['area'],
      unit: map['unit'],
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      isActive: map['isActive'] == 1,
      createdDate: DateTime.parse(map['createdDate']),
    );
  }

 }
