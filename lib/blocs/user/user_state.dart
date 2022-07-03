part of 'user_bloc.dart';

abstract class UserState {
  final User user;

  const UserState({
    required this.user,
  });
}

class UserInitial extends UserState {
  const UserInitial({
    required super.user,
  });
}
