import 'dart:core';

class SettingModel {
  int? settingId;
  final int accountId;
  final String key;
  final String value;
  final String profile;
  bool isActive;
  DateTime? createdDate;

  SettingModel(
      {this.settingId,
      required this.accountId,
      required this.key,
      required this.value,
      required this.profile,
      this.isActive = true,
      this.createdDate});

  Map<String, dynamic> toMap() {
    return {
      'settingId': this.settingId,
      'accountId': this.accountId,
      'key': this.key,
      'value': this.value,
      'profile': this.profile,
      'isActive': this.isActive ? 1 : 0,
      'createdDate': createdDate?.toIso8601String(),
    };
  }

  factory SettingModel.fromMap(Map<String, dynamic> map) {
    return SettingModel(
      settingId: map['settingId'],
      accountId: map['accountId'],
      key: map['key'],
      value: map['value'],
      profile: map['profile'],
      isActive: map['isActive'] == 0,
      createdDate: DateTime.parse(map['createdDate']),
    );
  }
}