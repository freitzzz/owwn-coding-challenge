import 'package:jwt_io/jwt_io.dart';

class Session {
  final String accessToken;

  final String refreshToken;

  bool get hasExpired =>
      JwtToken.getExpirationDate(refreshToken).isBefore(DateTime.now());

  const Session({
    required this.accessToken,
    required this.refreshToken,
  });

  Session.fromJson(
    final Map<String, dynamic> json,
  )   : accessToken = json['access_token'] as String,
        refreshToken = json['refresh_token'] as String;

  Map<String, dynamic> toRefreshJson() {
    return {
      'refresh_token': refreshToken,
    };
  }
}
