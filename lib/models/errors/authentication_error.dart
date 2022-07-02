import 'package:owwn_coding_challenge/data/data.dart';
import 'package:owwn_coding_challenge/models/errors/errors.dart';

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

  static AuthenticationError parse(ErrorResponse error) {
    final currrentStackTrace = StackTrace.current;

    if (error.statusCode == 401) {
      return InvalidSessionAuthenticationError(
        stacktrace: currrentStackTrace,
      );
    } else {
      final apiError = APIError.fromJson(error.json);

      if (apiError.isInvalidRequest) {
        return InvalidCredentialsAuthenticationError(
          stacktrace: currrentStackTrace,
        );
      } else {
        return UnknownAuthenticationError(
          cause: apiError.message,
          stacktrace: currrentStackTrace,
        );
      }
    }
  }
}

class InvalidCredentialsAuthenticationError extends AuthenticationError {
  const InvalidCredentialsAuthenticationError({
    required StackTrace stacktrace,
  }) : super(cause: 'Invalid Credentials', stacktrace: stacktrace);
}

class InvalidSessionAuthenticationError extends AuthenticationError {
  const InvalidSessionAuthenticationError({
    required StackTrace stacktrace,
  }) : super(cause: 'Session has expired or not valid', stacktrace: stacktrace);
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
