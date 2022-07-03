import 'package:dartz/dartz.dart';
import 'package:owwn_coding_challenge/core/throw.dart';
import 'package:owwn_coding_challenge/data/clients/clients.dart';
import 'package:owwn_coding_challenge/models/models.dart';

abstract class UsersRepository {
  Future<Either<RequestError, List<User>>> users({
    required final int page,
    required final int limit,
  });
}

class FakeUsersRepository extends UsersRepository {
  final _fakeUsers = const [
    User(
      id: 'soheil@owwn.com',
      name: 'Soheil',
      email: 'soheil@owwn.com',
      gender: Gender.male,
      status: Status.active,
      statistics: [],
    ),
    User(
      id: 'daniel@owwn.com',
      name: 'Daniel',
      email: 'daniel@owwn.com',
      gender: Gender.male,
      status: Status.active,
      statistics: [],
    ),
    User(
      id: 'daniel1@owwn.com',
      name: 'Daniel',
      email: 'daniel@owwn.com',
      gender: Gender.male,
      status: Status.active,
      statistics: [],
    ),
    User(
      id: 'daniel4@owwn.com',
      name: 'Daniel',
      email: 'daniel@owwn.com',
      gender: Gender.male,
      status: Status.active,
      statistics: [],
    ),
    User(
      id: 'daniel5@owwn.com',
      name: 'Daniel',
      email: 'daniel@owwn.com',
      gender: Gender.male,
      status: Status.active,
      statistics: [],
    ),
    User(
      id: 'amir@owwn.com',
      name: 'Amir',
      email: 'amir@owwn.com',
      gender: Gender.male,
      status: Status.inactive,
      statistics: [],
    ),
    User(
      id: 'daniel5@owwn.com',
      name: 'Daniel',
      email: 'daniel@owwn.com',
      gender: Gender.male,
      status: Status.active,
      statistics: [],
    ),
    User(
      id: 'umit@owwn.com',
      name: 'Umit',
      email: 'umit@owwn.com',
      gender: Gender.male,
      status: Status.inactive,
      statistics: [],
    ),
    User(
      id: 'umit@owwn.com',
      name: 'Umit',
      email: 'umit@owwn.com',
      gender: Gender.male,
      status: Status.inactive,
      statistics: [],
    ),
    User(
      id: 'umit@owwn.com',
      name: 'Umit',
      email: 'umit@owwn.com',
      gender: Gender.male,
      status: Status.inactive,
      statistics: [],
    ),
    User(
      id: 'umit@owwn.com',
      name: 'Umit',
      email: 'umit@owwn.com',
      gender: Gender.male,
      status: Status.inactive,
      statistics: [],
    ),
    User(
      id: 'umit@owwn.com',
      name: 'Umit',
      email: 'umit@owwn.com',
      gender: Gender.male,
      status: Status.inactive,
      statistics: [],
    ),
    User(
      id: 'umit@owwn.com',
      name: 'Umit',
      email: 'umit@owwn.com',
      gender: Gender.male,
      status: Status.inactive,
      statistics: [],
    ),
    User(
      id: 'umit@owwn.com',
      name: 'Umit',
      email: 'umit@owwn.com',
      gender: Gender.male,
      status: Status.inactive,
      statistics: [],
    ),
  ];

  @override
  Future<Either<RequestError, List<User>>> users({
    required int page,
    required int limit,
  }) {
    return Future.value(
      Right(_fakeUsers),
    );
  }
}

class OWWNUsersRepository extends UsersRepository {
  final OWWNCodingNetworkingClient client;

  OWWNUsersRepository({
    required this.client,
  });

  @override
  Future<Either<RequestError, List<User>>> users({
    required int page,
    required int limit,
  }) {
    return safeAsyncThrowCall(
      () async {
        final response = await client.get(
          endpoint: usersEndpoint,
          queryParameters: usersQueryParameters(page, limit),
        );

        return response.fold(
          (l) => Left(l),
          (r) {
            if (r is JsonResponse) {
              return Right(
                parseUsersJson(r.json),
              );
            } else if (r is ErrorResponse) {
              return Left(
                InvalidSessionAuthenticationError(
                  stacktrace: StackTrace.current,
                ),
              );
            } else {
              return Left(
                UnknownError(
                  stackTrace: StackTrace.current,
                  cause: 'could not parse $r response',
                ),
              );
            }
          },
        );
      },
    );
  }
}
