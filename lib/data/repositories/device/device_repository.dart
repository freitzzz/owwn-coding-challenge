import 'package:dartz/dartz.dart';
import 'package:owwn_coding_challenge/core/throw.dart';
import 'package:owwn_coding_challenge/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DeviceRepository {
  Future<Either<DeviceError, Option<String>>> read({
    required final String key,
  });

  Future<Either<DeviceError, void>> write({
    required final String key,
    required final String value,
  });
}

class FakeDeviceRepository extends DeviceRepository {
  final Map<String, String> _fakeData = {};

  @override
  Future<Either<DeviceError, Option<String>>> read({
    required String key,
  }) {
    return Future.value(
      Right(
        optionOf(_fakeData[key]),
      ),
    );
  }

  @override
  Future<Either<DeviceError, void>> write({
    required String key,
    required String value,
  }) {
    _fakeData[key] = value;

    return Future.value(
      const Right(null),
    );
  }
}

class SharedPreferencesDeviceRepository extends DeviceRepository {
  final SharedPreferences sharedPreferences;

  SharedPreferencesDeviceRepository({
    required this.sharedPreferences,
  });

  @override
  Future<Either<DeviceError, Option<String>>> read({
    required String key,
  }) {
    return safeAsyncThrowCall(
      () {
        return Future.value(
          Right(
            optionOf(
              sharedPreferences.getString(key),
            ),
          ),
        );
      },
      onError: (_, stackTrace) => ReadDeviceError(
        stacktrace: stackTrace,
      ),
    );
  }

  @override
  Future<Either<DeviceError, void>> write({
    required String key,
    required String value,
  }) {
    return safeAsyncThrowCall(
      () async {
        final didWrite = await sharedPreferences.setString(key, value);

        if (didWrite) {
          return const Right(null);
        } else {
          return Left(
            WriteDeviceError(
              stacktrace: StackTrace.current,
            ),
          );
        }
      },
      onError: (_, stackTrace) => WriteDeviceError(
        stacktrace: stackTrace,
      ),
    );
  }
}
