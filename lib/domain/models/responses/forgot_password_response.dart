import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_response.g.dart';

@JsonSerializable()
class ForgotPasswordResponse {
  final String code;

  const ForgotPasswordResponse(this.code);

  factory ForgotPasswordResponse.fromMap(Map<String, dynamic> json) {
    return ForgotPasswordResponse(json['data']['code']);
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code
    };
  }
}