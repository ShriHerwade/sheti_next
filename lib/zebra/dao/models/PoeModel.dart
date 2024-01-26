import 'dart:core';

class PoeModel {
  final int? poeId;
  final int accountId;
  final String poeName;
  final String? email;
  final String? mobileNo;
  final String? address;
  final bool isCreditor;
  final bool isShopFirm;
  final bool isBuyer;
  final bool isServiceProvider;
  final bool isFarmWorker;
  final bool isActive;
  DateTime? createdDate;

  PoeModel(
      {this.poeId,
      required this.accountId,
      required this.poeName,
      this.email,
      this.mobileNo,
      this.address,
      required this.isCreditor, // who gives the credit for purchase
      required this.isShopFirm, // whether it is a shop or firm
      required this.isBuyer, // who purchase the goods
      required this.isServiceProvider, // who provide the services in the farm
      required this.isFarmWorker, // who works in our farm or wage
      required this.isActive,
      this.createdDate});

  Map<String, dynamic> toMap() {
    return {
      'poeId': this.poeId,
      'accountId': this.accountId,
      'poeName': this.poeName,
      'email': this.email,
      'mobileNo': this.mobileNo,
      'address': this.address,
      'isCreditor': this.isCreditor ? 1 : 0,
      'isShopFirm': this.isShopFirm ? 1 : 0,
      'isBuyer': this.isBuyer ? 1 : 0,
      'isServiceProvider': this.isServiceProvider ? 1 : 0,
      'isFarmWorker': this.isFarmWorker ? 1 : 0,
      'isActive': this.isActive ? 1 : 0, // Convert boolean to integer
      'createdDate': this.createdDate?.toIso8601String(),
    };
  }

    factory PoeModel.fromMap(Map<String, dynamic> map) {
    return PoeModel(
      poeId: map['poeId'] as int,
      accountId: map['accountId'] as int,
      poeName: map['poeName'] as String,
      email: map['email'] != null ? map['email'] as String : '',
      mobileNo: map['mobileNo'] != null ? map['mobileNo'] as String : '',
      address: map['address'] != null ? map['address'] as String : '',
      isCreditor: map['isCreditor'] == 1,
      isShopFirm: map['isShopFirm'] == 1,
      isBuyer: map['isBuyer'] == 1,
      isServiceProvider: map['isServiceProvider'] == 1,
      isFarmWorker: map['isFarmWorker'] == 1,
      isActive: map['isActive'] == 1,
      createdDate: map['createdDate'] != null ? DateTime.parse(map['createdDate'] as String) : null,

    );
  }
}
