import 'dart:core';

class FarmModel {
  int? farmId; // SQLite auto-incremented id
  final int accountId;
  final String farmName;
  String? farmAddress;
  final double farmArea;
  final String unit;
  final String farmType;
  double? latitude;
  double? longitude;
  String? irrigationType;
  String? soilType;
  bool isActive;
  bool isExpanded;
  final DateTime createdDate;

  FarmModel(
      {this.farmId,
      required this.accountId,
      required this.farmName,
      this.farmAddress,
      required this.farmArea,
      required this.unit,
      required this.farmType,
      this.latitude,
      this.longitude,
      this.irrigationType,
      this.soilType,
      this.isActive = true,
      this.isExpanded = true,
      required this.createdDate});

  Map<String, dynamic> toMap() {
    return {
      'farmId': this.farmId,
      'accountId': this.accountId,
      'farmName': this.farmName,
      'farmAddress': this.farmAddress,
      'farmArea': this.farmArea,
      'unit': this.unit,
      'farmType': this.farmType,
      'latitude': this.latitude,
      'longitude': this.longitude,
      'irrigationType': this.irrigationType,
      'soilType': this.soilType,
      'isActive': isActive ? 1 : 0,
      'createdDate': createdDate?.toIso8601String(),
    };
  }

  factory FarmModel.fromMap(Map<String, dynamic> map) {
    return FarmModel(
      farmId: map['farmId'],
      accountId: map['accountId'],
      farmName: map['farmName'],
      farmAddress: map['farmAddress'],
      farmArea: map['farmArea'],
      unit: map['unit'],
      farmType: map['farmType'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      irrigationType: map['irrigationType'],
      soilType: map['soilType'],
      isActive: map['isActive'] == 1,
      isExpanded: map['isExpanded'] == 1,
      createdDate: DateTime.parse(map['createdDate']),
    );
  }
}
