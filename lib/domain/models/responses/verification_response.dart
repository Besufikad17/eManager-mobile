import 'package:json_annotation/json_annotation.dart';

part 'verification_response.g.dart';

@JsonSerializable()
class VerificationResponse {
  final String status;

  const VerificationResponse(this.status);

  factory VerificationResponse.fromMap(Map<String, dynamic> json) {
    return VerificationResponse(json['message']);
  }

  Map<String, dynamic> toMap() {
    return {
      'message': status
    };
  }
}