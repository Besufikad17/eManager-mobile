part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserLoginLoading extends UserEvent {
  const UserLoginLoading();

  @override
  List<Object?> get props => [];
}

class UserRegisterLoading extends UserEvent {
  const UserRegisterLoading();

  @override
  List<Object?> get props => [];
}

class UserLoginEvent extends UserEvent {
  final String email;
  final String password;

  const UserLoginEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class UserRegisterEvent extends UserEvent {
  final String fname;
  final String lname;
  final String phonenumber;
  final String email;
  final String password;

  const UserRegisterEvent(
    this.fname,
    this.lname,
    this.phonenumber,
    this.email, 
    this.password
  );

  @override
  List<Object?> get props => [
    fname,
    lname,
    phonenumber,
    email, 
    password
  ];
}

class ForgotPasswordEvent extends UserEvent {
  final String email;
  const ForgotPasswordEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class VerificationEvent extends UserEvent {
  final String code;
  final String email;

  const VerificationEvent(this.code, this.email);

  @override
  List<Object?> get props => [code, email];
}

class ChangePasswordEvent extends UserEvent {
  final String? id;
  final String? email;
  final String newPassword;

  const ChangePasswordEvent(this.id, this.email, this.newPassword);

  @override
  List<Object?> get props => [
    id,
    email,
    newPassword
  ];
}

class UserLogoutEvent extends UserEvent {
  const UserLogoutEvent();

  @override
  List<Object?> get props => [];
}

class GetPFP extends UserEvent {
  final String id;
  final String token;

  const GetPFP(this.id, this.token);

  @override
  List<Object?> get props => [id];
}

class EditProfileEvent extends UserEvent {
  final String id;
  final User user;
  final String token;

  const EditProfileEvent(this.id, this.user, this.token);

  @override
  List<Object?> get props => [id, user, token];
}

class GetUserById extends UserEvent {
  final String id;
  final String token;

  const GetUserById(this.id, this.token);

  @override
  List<Object?> get props => [id, token];
}

class RemoveUser extends UserEvent {
  final String id;
  final String token;

  const RemoveUser(this.id, this.token);

  @override
  List<Object?> get props => [id, token];
}