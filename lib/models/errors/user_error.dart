import 'package:owwn_coding_challenge/data/data.dart';

abstract class UserError extends RequestError {
  const UserError({
    required String cause,
    required StackTrace stacktrace,
  }) : super(cause: cause, stackTrace: stacktrace);
}
