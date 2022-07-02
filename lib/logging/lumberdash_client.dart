import 'package:flutter/foundation.dart';
import 'package:owwn_coding_challenge/logging/logging.dart';

class MinimalPrintLumberdashClient implements LumberdashClient {
  @override
  void logError(dynamic exception, [dynamic stacktrace]) {
    debugPrint('[error]: $exception\nStacktrace: $stacktrace');
  }

  @override
  void logFatal(String message, [Map<String, String>? extras]) {
    debugPrint(
      '[fatal]: $message${extras != null ? '\nExtras: $extras' : ''} ',
    );
  }

  @override
  void logMessage(String message, [Map<String, String>? extras]) {
    debugPrint(
      '[info]: $message${extras != null ? '\nExtras: $extras' : ''} ',
    );
  }

  @override
  void logWarning(String message, [Map<String, String>? extras]) {
    debugPrint(
      '[warning]: $message${extras != null ? '\nExtras: $extras' : ''} ',
    );
  }
}
