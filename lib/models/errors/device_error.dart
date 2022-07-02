import 'package:owwn_coding_challenge/data/data.dart';

abstract class DeviceError extends RequestError {
  const DeviceError({
    required String cause,
    required StackTrace stacktrace,
  }) : super(cause: cause, stackTrace: stacktrace);
}

class ReadDeviceError extends DeviceError {
  const ReadDeviceError({
    required StackTrace stacktrace,
  }) : super(cause: 'Could not read device data', stacktrace: stacktrace);
}

class WriteDeviceError extends DeviceError {
  const WriteDeviceError({
    required StackTrace stacktrace,
  }) : super(cause: 'Could not write device data', stacktrace: stacktrace);
}
