import 'package:dartz/dartz.dart';
import 'package:http/http.dart' hide Request, Response;
import 'package:networking/networking.dart';

const authEndpoint = 'auth';
const refreshEndpoint = 'refresh';
const usersEndpoint = 'users';

Map<String, String> usersQueryParameters(final int page, final int limit) {
  return {
    'page': page.toString(),
    'limit': limit.toString(),
  };
}

class OWWNCodingNetworkingClient extends NetworkingClient {
  OWWNCodingNetworkingClient()
      : super(
          baseUrl: Uri.parse('https://ccoding.owwn.com/hermes'),
          httpClient: Client(),
        );

  @override
  Future<Either<RequestError, Response>> send({
    required final Request request,
  }) {
    return super.send(
      request: request.copyWith(
        headers: Map.of(request.headers)
          ..addAll(
            {
              'X-API-KEY': 'owwn-challenge-22bbdk',
            },
          ),
      ),
    );
  }
}
