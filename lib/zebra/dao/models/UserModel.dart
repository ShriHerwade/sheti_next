import 'dart:core';

class UserModel {
  final int? userId;
  final int accountId;
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNo;
  final String pin;
  final bool isActive;
  final bool isAccountOwner;
  final String role;
  DateTime? expirationDate;
  DateTime? createdDate;
  DateTime? lastAccessedDate;

  UserModel(
      {this.userId,
      required this.accountId,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.mobileNo,
        required this.pin,
      this.isActive = true,
      this.isAccountOwner = false,
      required this.role,
      this.expirationDate,
      this.createdDate,
      this.lastAccessedDate});

  Map<String, dynamic> toMap() { // change the hardoded values once all ready
    return {
      'userId': this.userId,
      'accountId': this.accountId,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'email': this.email,
      'mobileNo': this.mobileNo,
      'pin': 123456,
      'isActive': true,
      'isAccountOwner': this.isAccountOwner,
      'role': "Admin",
      'expirationDate': this.expirationDate?.toIso8601String(),
      'createdDate': this.createdDate?.toIso8601String(),
      'lastAccessedDate': this.lastAccessedDate?.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'],
      accountId: map['accountId'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      mobileNo: map['mobileNo'],
      pin: map['pin'],
      isActive: map['isActive'] == 1,
      isAccountOwner: map['isAccountOwner'] == 1,
      role: map['role'],
      expirationDate: DateTime.parse(map['expirationDate']),
      createdDate: DateTime.parse(map['createdDate']),
      lastAccessedDate: DateTime.parse(map['lastAccessedDate']),
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      userId: json['userId'],
      accountId: json['accountId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      mobileNo: json['mobileNo'],
      pin: json['pin'],
      isActive: json['isActive'],
      isAccountOwner: json['isAccountOwner'],
      role: json['role'],
      expirationDate: json['expirationDate'] != null
          ? DateTime.parse(json['expirationDate'])
          : null,
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'])
          : null,
      lastAccessedDate: json['lastAccessedDate'] != null
          ? DateTime.parse(json['lastAccessedDate'])
          : null,
    );
  }
}
