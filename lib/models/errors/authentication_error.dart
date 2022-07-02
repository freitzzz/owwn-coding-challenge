import 'package:owwn_coding_challenge/data/data.dart';

abstract class AuthenticationError extends RequestError {
  const AuthenticationError({
    required String cause,
    required StackTrace stacktrace,
  }) : super(cause: cause, stackTrace: stacktrace);
}
