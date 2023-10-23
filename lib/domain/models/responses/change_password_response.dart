import 'package:json_annotation/json_annotation.dart';

part 'change_password_response.g.dart';

@JsonSerializable()
class ChangePasswordResponse {
  final String status;
  const ChangePasswordResponse(this.status);

  factory ChangePasswordResponse.fromMap(Map<String, dynamic> json) {
    return ChangePasswordResponse(json['message']);
  }

  Map<String, dynamic> toMap() {
    return {
      'message': status
    };
  }
}