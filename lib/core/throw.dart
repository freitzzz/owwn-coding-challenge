import 'package:dartz/dartz.dart';
import 'package:owwn_coding_challenge/data/data.dart';
import 'package:owwn_coding_challenge/logging/logging.dart';

Future<Either<L, R>> safeAsyncThrowCall<L extends RequestError, R>(
  Future<Either<L, R>> Function() call, {
  RequestError Function(Object error, StackTrace stackTrace)? onError,
}) async {
  try {
    return await call();
  } on Object catch (error, stacktrace) {
    logError(error, stacktrace: stacktrace);

    return Left(
      (onError?.call(error, stacktrace) ??
          UnknownError(
            cause: error.toString(),
            stackTrace: stacktrace,
          )) as L,
    );
  }
}
