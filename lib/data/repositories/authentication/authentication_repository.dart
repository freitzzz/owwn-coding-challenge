import 'package:dartz/dartz.dart';
import 'package:owwn_coding_challenge/models/models.dart';

abstract class AuthenticationRepository {
  Future<Either<AuthenticationError, void>> auth({
    required final String email,
  });

  Future<Either<AuthenticationError, void>> refresh({
    required final String token,
  });
}

class FakeAuthenticationRepository extends AuthenticationRepository {
  @override
  Future<Either<AuthenticationError, void>> auth({
    required String email,
  }) {
    return Future.value(
      const Right(null),
    );
  }

  @override
  Future<Either<AuthenticationError, void>> refresh({
    required String token,
  }) {
    return Future.value(
      const Right(null),
    );
  }
}
