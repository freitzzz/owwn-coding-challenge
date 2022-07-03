part of 'users_bloc.dart';

// class UsersBatch {
//   final List<User> activeUsers;

//   final List<User> inactiveUsers;

//   factory UsersBatch({
//     required final List<User> users,
//   }) {
//     final activeUsers = <User>[];

//     final inactiveUsers = <User>[];

//     for (final u in users) {
//       if (u.active) {
//         activeUsers.add(u);
//       } else {
//         inactiveUsers.add(u);
//       }
//     }

//     return UsersBatch._(
//       activeUsers: activeUsers,
//       inactiveUsers: inactiveUsers,
//     );
//   }

//   const UsersBatch._({
//     required this.activeUsers,
//     required this.inactiveUsers,
//   });
// }

abstract class UsersState {
  final List<User> users;

  int get totalCount => users.length;

  const UsersState({
    required this.users,
  });
}

class UsersInitial extends UsersState {
  const UsersInitial({
    super.users = const [],
  });
}

class FetchUsersSuccess extends UsersState {
  const FetchUsersSuccess({
    required super.users,
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
  });
}
