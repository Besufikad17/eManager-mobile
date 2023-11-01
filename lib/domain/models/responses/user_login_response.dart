import 'package:cleanarchdemo/domain/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_login_response.g.dart';

@JsonSerializable()
class UserLoginResponse extends Equatable {
  final User? user;
  final String? token;
  final String? message;

  const UserLoginResponse(this.user, this.token, this.message);

  factory UserLoginResponse.fromMap(Map<String, dynamic> map) {
    return UserLoginResponse(
        User.fromJson(map['user']),
        map['token'] ?? '',
        map['message'] ?? ''
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user ?? '',
      'token': token ?? '',
      'message': message ?? ''
    };
  }

  @override
  List<Object?> get props => [user, token];
}
