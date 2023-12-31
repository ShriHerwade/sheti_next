import 'dart:core';

class AccountModel {
  int? accountId;
  late DateTime activationDate;
  late String activationType;
  late DateTime expirationDate;
  late String platform;
  String? transactionId;
  String? receipt;
  String? rawData;
  final bool disableAccount;
  DateTime? createdDate;

  AccountModel(
      {this.accountId,
      required this.activationDate,
      required this.activationType,
      required this.expirationDate,
      required this.platform,
      this.transactionId,
      this.receipt,
      this.rawData,
      this.disableAccount = false,
      required this.createdDate});

  Map<String, dynamic> toMap() {
    return {
      'accountId': this.accountId,
      'activationDate': this.activationDate?.toIso8601String(),
      'activationType': this.activationType,
      'expirationDate': this.expirationDate?.toIso8601String(),
      'platform': this.platform,
      'transactionId': this.transactionId,
      'receipt': this.receipt,
      'rawData': this.rawData,
      'disableAccount': this.disableAccount ? 1 : 0,
      'createdDate': createdDate?.toIso8601String(),
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      accountId: map['accountId'],
      activationDate: map['activationDate'],
      activationType: map['activationType'],
      expirationDate: map['expirationDate'],
      platform: map['platform'],
      transactionId: map['transactionId'],
      receipt: map['receipt'],
      rawData: map['rawData'],
      disableAccount: map['disableAccount'] == 0,
      createdDate: DateTime.parse(map['createdDate']),
    );
  }

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      accountId: json['accountId'],
      activationDate: json['activationDate'],
      activationType: json['activationType'],
      expirationDate: json['expirationDate'],
      platform: json['platform'],
      transactionId: json['transactionId'],
      receipt: json['receipt'],
      rawData: json['rawData'],
      disableAccount: json['disableAccount'],
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'])
          : null,
    );
  }
}
