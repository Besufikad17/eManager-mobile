import 'package:json_annotation/json_annotation.dart';

part 'user_signup_request.g.dart';

@JsonSerializable()
class UserSignUpRequest {
  final String fname;
  final String lname;
  final String email;
  final String phonenumber;
  final String password;

  const UserSignUpRequest(
    this.fname,
    this.lname,
    this.email,
    this.phonenumber,
    this.password
  );

  factory UserSignUpRequest.fromMap(Map<String, dynamic> json) {
    return UserSignUpRequest(
      json['fname'], 
      json['lname'], 
      json['email'], 
      json['phonenumber'], 
      json['password']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fname': fname,
      'lname': lname,
      'email': email,
      'phonenumber': phonenumber,
      'password': password
    };
  }
}
