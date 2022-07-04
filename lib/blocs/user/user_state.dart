part of 'user_bloc.dart';

abstract class UserState {
  final User user;

  final TextEditingController emailTextEditingController;
  final TextEditingController nameTextEditingController;

  const UserState({
    required this.user,
    required this.emailTextEditingController,
    required this.nameTextEditingController,
  });
}

class UserInitial extends UserState {
  const UserInitial({
    required super.user,
    required super.emailTextEditingController,
    required super.nameTextEditingController,
  });
}

class UserEditInProgress extends UserState {
  const UserEditInProgress({
    required super.user,
    required super.emailTextEditingController,
    required super.nameTextEditingController,
  });
}

class UserEdit extends UserState {
  const UserEdit({
    required super.user,
    required super.emailTextEditingController,
    required super.nameTextEditingController,
  });
}

class UserSaveInProgress extends UserEditInProgress {
  const UserSaveInProgress({
    required super.user,
    required super.emailTextEditingController,
    required super.nameTextEditingController,
  });
}

class UserSaveSuccess extends UserState {
  const UserSaveSuccess({
    required super.user,
    required super.emailTextEditingController,
    required super.nameTextEditingController,
  });
}

class UserSaveFailure extends UserEditInProgress {
  const UserSaveFailure({
    required super.user,
    required super.emailTextEditingController,
    required super.nameTextEditingController,
  });
}
