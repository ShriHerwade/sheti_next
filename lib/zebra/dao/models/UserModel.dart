import 'dart:core';

class UserModel {
  late String firstName;
  late String lastName;
  late String email;
  late String mobileNo;// set mobile no as PK
  late String pin;

  UserModel(
      this.firstName, this.lastName, this.email, this.mobileNo, this.pin);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'mobileNo': mobileNo,
      "pin": pin
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    firstName = map['firstName'];
    lastName = map['lastName'];
    email = map['email'];
    mobileNo = map['mobileNo'];
    pin = map['pin'];
  }
}
