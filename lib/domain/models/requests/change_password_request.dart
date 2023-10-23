import 'package:json_annotation/json_annotation.dart';

part 'change_password_request.g.dart';

@JsonSerializable()
class ChangePasswordRequest {
  final String? id;
  final String? email;
  final String newPassword;
  const ChangePasswordRequest(this.id, this.email, this.newPassword);

  factory ChangePasswordRequest.fromMap(Map<String, dynamic> json) {
    return ChangePasswordRequest(
      json['id'] ?? '',
      json['email'] ?? '',
      json['newPassword']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id ?? '',
      'email': email ?? '',
      'newPassword': newPassword
    };
  }
}