import 'package:json_annotation/json_annotation.dart';

part 'user_login_request.g.dart';

@JsonSerializable()
class UserLoginRequest {
  final String email;
  final String password;

  const UserLoginRequest(this.email, this.password);

  factory UserLoginRequest.fromMap(Map<String, dynamic> json) {
    return UserLoginRequest(json['email'], json['password']);
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password
    };
  }
}
