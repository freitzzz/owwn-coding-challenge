part of 'users_bloc.dart';

abstract class UsersEvent {}

class FetchUsersEvent extends UsersEvent {}

class RefreshUserEvent extends UsersEvent {
  final User user;

  RefreshUserEvent({
    required this.user,
  });
}
