part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

final class UserInitial extends UserState {
  const UserInitial();

  @override
  List<Object> get props => [];
}

final class UserLoaded extends UserState {
  final User user;

  const UserLoaded(this.user);

  @override
  List<Object> get props => [user];
}

final class UserError extends UserState {
  final String? message;

  const UserError(this.message);

  @override
  List<Object> get props => [message!];
}
