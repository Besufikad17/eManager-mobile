import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserLoginRequest {
  final String email;
  final String password;

  const UserLoginRequest(this.email, this.password);
}
