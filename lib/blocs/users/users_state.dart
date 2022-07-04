part of 'users_bloc.dart';

abstract class UsersState {
  final List<User> users;

  final bool hasFetchedAllUsers;

  int get totalCount => users.length;

  const UsersState({
    required this.users,
    required this.hasFetchedAllUsers,
  });

  bool canRequestMoreUsers(final int index) {
    final usersUntilLimitIsBeingReached = totalCount - 5;

    return usersUntilLimitIsBeingReached > 0 &&
        index > usersUntilLimitIsBeingReached &&
        !hasFetchedAllUsers;
  }
}

class UsersInitial extends UsersState {
  const UsersInitial({
    super.users = const [],
    super.hasFetchedAllUsers = false,
  });
}

class FetchUsersSuccess extends UsersState {
  const FetchUsersSuccess({
    required super.users,
    required super.hasFetchedAllUsers,
  });

  @override
  int get hashCode => users.hashCode;

  @override
  bool operator ==(Object other) {
    return super.hashCode == other.hashCode;
  }
}

class FetchUsersFailure extends UsersState {
  final RequestError error;

  const FetchUsersFailure({
    required super.users,
    required super.hasFetchedAllUsers,
    required this.error,
  });
}

class RefreshUsers extends UsersState {
  const RefreshUsers({
    required super.users,
    required super.hasFetchedAllUsers,
  });
}
