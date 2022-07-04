part of 'users_bloc.dart';

abstract class UsersState {
  final List<User> users;

  final int limit;

  int get totalCount => users.length;

  const UsersState({
    required this.users,
    required this.limit,
  });

  bool canRequestMoreUsers(final int index) {
    final usersUntilLimitIsBeingReached = totalCount - limit;

    return usersUntilLimitIsBeingReached > 0 &&
        index > usersUntilLimitIsBeingReached;
  }
}

class UsersInitial extends UsersState {
  const UsersInitial({
    super.users = const [],
    super.limit = 0,
  });
}

class FetchUsersSuccess extends UsersState {
  const FetchUsersSuccess({
    required super.users,
    required super.limit,
  });

  @override
  int get hashCode => users.hashCode;

  @override
  bool operator ==(Object other) {
    return super.hashCode == other.hashCode;
  }
}

class FetchUsersFailure extends UsersState {
  const FetchUsersFailure({
    required super.users,
    required super.limit,
  });
}

class RefreshUsers extends UsersState {
  const RefreshUsers({
    required super.users,
    required super.limit,
  });
}
