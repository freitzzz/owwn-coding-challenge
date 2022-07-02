import 'package:owwn_coding_challenge/data/data.dart';

abstract class AuthenticationError extends RequestError {
  const AuthenticationError({
    required String cause,
    required StackTrace stacktrace,
  }) : super(cause: cause, stackTrace: stacktrace);

  static AuthenticationError from(RequestError error) {
    if (error is AuthenticationError) {
      return error;
    } else {
      return UnknownAuthenticationError(
        cause: error.cause,
        stacktrace: error.stackTrace,
      );
    }
  }
}

class InvalidCredentialsAuthenticationError extends AuthenticationError {
  const InvalidCredentialsAuthenticationError({
    required StackTrace stacktrace,
  }) : super(cause: 'Invalid Credentials', stacktrace: stacktrace);
}

class UnknownAuthenticationError extends AuthenticationError {
  UnknownAuthenticationError({
    final String? cause,
    required StackTrace stacktrace,
  }) : super(
          cause: 'Unknown Error on Authentication: ${cause?.toString() ?? ''}',
          stacktrace: stacktrace,
        );
}
