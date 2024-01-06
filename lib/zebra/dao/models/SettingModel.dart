import 'dart:core';
class SettingModel {
  int? settingId;
  final String key;
  final String value;
  final String profile;
  bool isActive;
  DateTime? createdDate;

  SettingModel(
      {this.settingId,
      required this.key,
      required this.value,
      required this.profile,
      this.isActive = true,
      this.createdDate});

  Map<String, dynamic> toMap() {
    return {
      'settingId': this.settingId,
      'key': this.key,
      'value': this.value,
      'profile': this.profile,
      'isActive': this.isActive ? 1 : 0, // Convert boolean to integer,
      'createdDate': createdDate?.toIso8601String(),
    };
  }

  factory SettingModel.fromMap(Map<String, dynamic> map) {
    return SettingModel(
      settingId: map['settingId'],
      key: map['key'],
      value: map['value'],
      profile: map['profile'],
      isActive: map['isActive'] == 0,
      createdDate: DateTime.parse(map['createdDate']),
    );
  }

  // Factory method to create a SettingModel from JSON
  factory SettingModel.fromJson(Map<String, dynamic> json) {
    try {
      return SettingModel(
        key: json['key'],
        value: json['value'],
        profile: json['profile'],
        isActive: json['isActive'],
        createdDate: json['createdDate'] != null
            ? DateTime.parse(json['createdDate'])
            : null,
      );
    }catch (e) {
  print("Error parsing settings JSON: $e");
  rethrow;  // Re-throw the exception after printing the error
  }
  }
}
