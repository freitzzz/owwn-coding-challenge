part of 'user_bloc.dart';

abstract class UserEvent {}

class UserSaveEvent extends UserEvent {}

class UserNameUpdated extends UserEvent {}
