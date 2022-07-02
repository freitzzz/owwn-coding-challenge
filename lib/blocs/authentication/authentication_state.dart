part of 'authentication_bloc.dart';

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationInProgress extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final Session session;

  AuthenticationSuccess({
    required this.session,
  });
}

class AuthenticationFailure extends AuthenticationState {
  final AuthenticationError error;

  AuthenticationFailure({
    required this.error,
  });
}
