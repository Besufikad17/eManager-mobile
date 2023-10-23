part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

final class UserInitial extends UserState {
  const UserInitial();

  @override
  List<Object> get props => [];
}

final class UserLoading extends UserState {
  const UserLoading();

  @override
  List<Object?> get props => [];
}

final class UserLoggedOut extends UserState {
  const UserLoggedOut();

  @override
  List<Object?> get props => [];
}

final class UserLoaded extends UserState {
  final User user;
  final String token;

  const UserLoaded(this.user, this.token);

  @override
  List<Object> get props => [user];
}


final class ForgotPassword extends UserState {
  final String code;
  const ForgotPassword(this.code);

  @override
  List<Object?> get props => [code];
}

final class Verified extends UserState {
  final String status;
  const Verified(this.status);

  @override
  List<Object?> get props => [status];
}

final class UserError extends UserState {
  final String? message;

  const UserError(this.message);

  @override
  List<Object> get props => [message!];
}

