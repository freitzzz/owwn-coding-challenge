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
