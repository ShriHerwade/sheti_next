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
      required this.isActive,
      required this.isAccountOwner,
      required this.role,
      this.expirationDate,
      this.createdDate,
      this.lastAccessedDate});

  factory UserModel.fromJson(Map<String, dynamic> json){
    try{
    return UserModel(
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
    }catch (e) {
      print("Error parsing user JSON: $e");
      rethrow;  // Re-throw the exception after printing the error
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': this.userId,
      'accountId': this.accountId,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'email': this.email,
      'mobileNo': this.mobileNo,
      'pin': this.pin,
      'isActive': this.isActive ? 1 : 0, // Convert boolean to integer
      'isAccountOwner': this.isAccountOwner ? 1 : 0, // Convert boolean to integer
      'role': this.role,
      'expirationDate': this.expirationDate?.toIso8601String(),
      'createdDate': this.createdDate?.toIso8601String(),
      'lastAccessedDate': this.lastAccessedDate?.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as int,
      accountId: map['accountId'] as int,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      mobileNo: map['mobileNo'] as String,
      pin: map['pin'] as String,
      isActive: map['isActive'] as bool,
      isAccountOwner: map['isAccountOwner'] as bool,
      role: map['role'] as String,
      expirationDate: map['expirationDate'] as DateTime,
      createdDate: map['createdDate'] as DateTime,
      lastAccessedDate: map['lastAccessedDate'] as DateTime,
    );
  }
}
