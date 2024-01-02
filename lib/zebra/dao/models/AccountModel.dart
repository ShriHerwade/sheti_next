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
      required this.disableAccount,
      this.createdDate});

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
      'disableAccount': this.disableAccount ? 1 : 0, // Convert boolean to integer
      'createdDate': this.createdDate?.toIso8601String(),
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      accountId: map['accountId'] as int,
      activationDate: map['activationDate'] != null
          ? DateTime.parse(map['activationDate'])
          : null,
      activationType: map['activationType'] as String,
      expirationDate: map['expirationDate'] != null
          ? DateTime.parse(map['expirationDate'])
          : null,
      platform: map['platform'] as String,
      transactionId: map['transactionId'] as String,
      receipt: map['receipt'] as String,
      rawData: map['rawData'] as String,
      disableAccount: map['disableAccount'] == 1, // without it parse error
      createdDate: map['createdDate'] != null
          ? DateTime.parse(map['createdDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "accountId": this.accountId,
      "activationDate": this.activationDate?.toIso8601String(),
      "activationType": this.activationType,
      "expirationDate": this.expirationDate?.toIso8601String(),
      "platform": this.platform,
      "transactionId": this.transactionId,
      "receipt": this.receipt,
      "rawData": this.rawData,
      "disableAccount": this.disableAccount,
      "createdDate": this.createdDate?.toIso8601String(),
    };
  }

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    try {
      return AccountModel(
        activationDate: json['activationDate'] != null
            ? DateTime.parse(json['activationDate'])
            : null,
        activationType: json["activationType"],
        expirationDate: json['expirationDate'] != null
            ? DateTime.parse(json['expirationDate'])
            : null,
        platform: json["platform"],
        transactionId: json["transactionId"],
        receipt: json["receipt"],
        rawData: json["rawData"],
        disableAccount: json["disableAccount"],
        createdDate: json['createdDate'] != null
            ? DateTime.parse(json['createdDate'])
            : null,
      );
    }catch (e) {
  print("Error parsing Account JSON: $e");
  rethrow;  // Re-throw the exception after printing the error
  }
  }
}
