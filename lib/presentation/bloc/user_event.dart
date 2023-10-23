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

class UserLogoutEvent extends UserEvent {
  const UserLogoutEvent();

  @override
  List<Object?> get props => [];
}
