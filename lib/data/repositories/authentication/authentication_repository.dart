import 'package:dartz/dartz.dart';
import 'package:owwn_coding_challenge/core/core.dart';
import 'package:owwn_coding_challenge/data/data.dart';
import 'package:owwn_coding_challenge/models/models.dart';

abstract class AuthenticationRepository {
  Future<Either<AuthenticationError, Session>> auth({
    required final Credentials credentials,
  });

  Future<Either<AuthenticationError, Session>> refresh({
    required final Session session,
  });
}

class FakeAuthenticationRepository extends AuthenticationRepository {
  final _fakeSession = {
    'access_token': 'fake_jwt',
    'refresh_token': 'fake_jwt',
  };

  @override
  Future<Either<AuthenticationError, Session>> auth({
    required Credentials credentials,
  }) {
    return Future.value(
      Right(
        Session.fromJson(_fakeSession),
      ),
    );
  }

  @override
  Future<Either<AuthenticationError, Session>> refresh({
    required Session session,
  }) {
    return Future.value(
      Right(
        Session.fromJson(_fakeSession),
      ),
    );
  }
}

class OWWNAuthenticationRepository extends AuthenticationRepository {
  final OWWNCodingNetworkingClient client;

  OWWNAuthenticationRepository({
    required this.client,
  });

  @override
  Future<Either<AuthenticationError, Session>> auth({
    required Credentials credentials,
  }) {
    return safeAsyncThrowCall(
      () async {
        final response = await client.post(
          endpoint: authEndpoint,
          data: credentials.toJson().encode,
        );

        return _foldSessionResponse(response);
      },
    );
  }

  @override
  Future<Either<AuthenticationError, Session>> refresh({
    required Session session,
  }) {
    return safeAsyncThrowCall(
      () async {
        final response = await client.post(
          endpoint: refreshEndpoint,
          data: session.toRefreshJson().encode,
        );

        return _foldSessionResponse(response);
      },
    );
  }

  Either<AuthenticationError, Session> _foldSessionResponse(
    final Either<RequestError, Response> response,
  ) {
    return response.fold(
      (l) => Left(AuthenticationError.from(l)),
      (r) {
        if (r is JsonResponse) {
          return Right(
            Session.fromJson(r.json),
          );
        } else if (r is ErrorResponse) {
          return Left(
            AuthenticationError.parse(r),
          );
        } else {
          return Left(
            UnknownAuthenticationError(
              stacktrace: StackTrace.current,
              cause: 'could not parse $r response',
            ),
          );
        }
      },
    );
  }
}
