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

  Map<String, dynamic> toMap() {
    return {
      'userId': this.userId,
      'accountId': this.accountId,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'email': this.email,
      'mobileNo': this.mobileNo,
      'pin': this.pin,
      'isActive': this.isActive,
      'isAccountOwner': this.isAccountOwner,
      'role': this.role,
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
}
