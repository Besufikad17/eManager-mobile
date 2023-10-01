import 'package:json_annotation/json_annotation.dart';

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
}
