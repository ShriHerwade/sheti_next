import 'dart:core';

class CropModel {
  int? cropId;
  int farmId;
  final String cropName;
  final String cropVariety;
  final String farmName;
  final double area;
  final String unit;
  final DateTime startDate;
  final DateTime endDate;
  double expectedIncome;
  double expectedYield;
  String expectedYieldUnit;
  double totalYield;
  String totalYieldUnit;
  double totalIncome;
  double totalExpense;
  String cropLifeState;
  final DateTime stateUpdatedDate;
  bool isActive;
  bool isExpanded;
  DateTime? createdDate;

  CropModel({
    this.cropId,
    required this.farmId,
    required this.cropName,
    required this.cropVariety,
    required this.farmName,
    required this.area,
    required this.unit,
    required this.startDate,
    required this.endDate,
    required this.expectedIncome,
    required this.expectedYield,
    required this.expectedYieldUnit,
    required this.totalYield,
    required this.totalYieldUnit,
    required this.totalIncome,
    required this.totalExpense,
    required this.cropLifeState, // Live or Dead
    required this.stateUpdatedDate,
    this.isActive = true,
    this.isExpanded = true,
    this.createdDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'cropId': this.cropId,
      'farmId': this.farmId,
      'cropName': this.cropName,
      'cropVariety': this.cropVariety,
      'farmName': this.farmName,
      'area': this.area,
      'unit': this.unit,
      'startDate': this.startDate?.toIso8601String(),
      'endDate': this.endDate?.toIso8601String(),
      'expectedIncome': this.expectedIncome,
      'expectedYield': this.expectedYield,
      'expectedYieldUnit': this.expectedYieldUnit,
      'totalYield': this.totalYield,
      'totalYieldUnit': this.totalYieldUnit,
      'totalIncome': this.totalIncome,
      'totalExpense': this.totalExpense,
      'cropLifeState': this.cropLifeState,
      'stateUpdatedDate': this.stateUpdatedDate.toIso8601String(),
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
      farmName: map['farmName'],
      area: map['area'],
      unit: map['unit'],
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      expectedIncome: map['expectedIncome'],
      expectedYield: map['expectedYield'],
      expectedYieldUnit: map['expectedYieldUnit'],
      totalYield: map['totalYield'],
      totalYieldUnit: map['totalYieldUnit'],
      totalIncome: map['totalIncome'],
      totalExpense: map['totalExpense'],
      cropLifeState: map['cropLifeState'],
      stateUpdatedDate: DateTime.parse(map['stateUpdatedDate']),
      isActive: map['isActive'] == 1,
      isExpanded: map['isExpanded'] == 1,
      createdDate: DateTime.parse(map['createdDate']),
    );
  }
}
