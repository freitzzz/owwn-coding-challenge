import 'package:http/http.dart';
import 'package:networking/networking.dart';

class OWWNCodingNetworkingClient extends NetworkingClient {
  OWWNCodingNetworkingClient()
      : super(
          baseUrl: Uri.parse('https://ccoding.owwn.com/hermes'),
          httpClient: Client(),
        );
}
