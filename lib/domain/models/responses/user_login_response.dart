import 'package:cleanarchdemo/domain/models/user.dart';

class UserLoginResponse {
  final User user;
  final String token;

  const UserLoginResponse(this.user, this.token);

  factory UserLoginResponse.fromMap(Map<String, dynamic> map) {
    return UserLoginResponse(map['user'], map['token']);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [user, token];
}
