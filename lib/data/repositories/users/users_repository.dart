import 'package:dartz/dartz.dart';
import 'package:owwn_coding_challenge/models/models.dart';

abstract class UsersRepository {
  Future<Either<UserError, void>> users({
    final int page,
    final int limit,
  });
}
