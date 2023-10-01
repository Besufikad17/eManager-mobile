import 'package:equatable/equatable.dart';
import 'package:cleanarchdemo/domain/models/user.dart';

class UserSignUpResponse extends Equatable {
  final User user;
  final String token;

  const UserSignUpResponse(this.user, this.token);

  factory UserSignUpResponse.fromMap(Map<String, dynamic> map) {
    return UserSignUpResponse(map['user'], map['token']);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [user, token];
}
