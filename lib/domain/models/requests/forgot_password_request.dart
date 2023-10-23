import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_request.g.dart';

@JsonSerializable()
class ForgotPasswordRequest {
  final String email;

  const ForgotPasswordRequest(this.email);

  factory ForgotPasswordRequest.fromMap(Map<String, dynamic> json) {
    return ForgotPasswordRequest(json['email']);
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email
    };
  }
}