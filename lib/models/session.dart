import 'package:jwt_io/jwt_io.dart';

const _almostExpiringDuration = Duration(minutes: 10);

const _jwtPrefix = 'eyJ';

class Session {
  final String accessToken;

  final String refreshToken;

  bool get hasNotExpired =>
      refreshToken.startsWith(_jwtPrefix) &&
      JwtToken.getExpirationDate(refreshToken).isAfter(DateTime.now());

  bool get isAlmostExpiring =>
      refreshToken.startsWith(_jwtPrefix) &&
      JwtToken.getExpirationDate(refreshToken).difference(DateTime.now()) <
          _almostExpiringDuration;

  const Session({
    required this.accessToken,
    required this.refreshToken,
  });

  const Session.expired() : this(accessToken: '', refreshToken: '');

  Session.fromJson(
    final Map<String, dynamic> json,
  )   : accessToken = json['access_token'] as String,
        refreshToken = json['refresh_token'] as String;

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  Map<String, dynamic> toRefreshJson() {
    return {
      'refresh_token': refreshToken,
    };
  }
}
