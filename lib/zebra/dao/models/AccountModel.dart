import 'dart:core';

class AccountModel {
  int? accountId;
  DateTime? activationDate;
  String activationType;
  DateTime? expirationDate;
  late String platform;
  String? transactionId;
  String? receipt;
  String? rawData;
  final bool disableAccount;
  DateTime? createdDate;

  AccountModel(
      {this.accountId,
      this.activationDate,
      required this.activationType,
      this.expirationDate,
      required this.platform,
      this.transactionId,
      this.receipt,
      this.rawData,
      this.disableAccount = false,
      this.createdDate});


  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      accountId: json['accountId'],
      activationDate: json['activationDate'] != null
          ? DateTime.parse(json['activationDate'])
          : null,
      activationType: json['activationType'],
      expirationDate: json['expirationDate'] != null
          ? DateTime.parse(json['expirationDate'])
          : null,
      platform: json['platform'],
      transactionId: json['transactionId'],
      receipt: json['receipt'],
      rawData: json['rawData'],
      disableAccount: json['disableAccount'] == 1, // Convert int to bool,
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accountId': this.accountId,
      'activationDate': this.activationDate,
      'activationType': this.activationType,
      'expirationDate': this.expirationDate,
      'platform': this.platform,
      'transactionId': this.transactionId,
      'receipt': this.receipt,
      'rawData': this.rawData,
      'disableAccount': this.disableAccount,
      'createdDate': this.createdDate,
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      accountId: map['accountId'] as int,
      activationDate: map['activationDate'] as DateTime,
      activationType: map['activationType'] as String,
      expirationDate: map['expirationDate'] as DateTime,
      platform: map['platform'] as String,
      transactionId: map['transactionId'] as String,
      receipt: map['receipt'] as String,
      rawData: map['rawData'] as String,
      disableAccount: map['disableAccount'] as bool,
      createdDate: map['createdDate'] as DateTime,
    );
  }
}
