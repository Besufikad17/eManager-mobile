import 'package:json_annotation/json_annotation.dart';

part 'verification_request.g.dart';

@JsonSerializable()
class VerificationRequest {
  final String email;
  final String code;

  const VerificationRequest(this.code, this.email);

  factory VerificationRequest.fromMap(Map<String, dynamic> json) {
    return VerificationRequest(
      json['code'],
      json['email']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'email': email
    };
  }
}