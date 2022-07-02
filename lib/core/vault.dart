import 'package:owwn_coding_challenge/data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Vault<T> {
  final _vault = <Type, T>{};

  void store<S extends T>(final S value) => _vault[S] = value;

  T? lookup<S extends T>() => _vault[S];
}

Future<Vault<Object>> createVault({
  required final bool isReleaseMode,
}) async {
  final vault = Vault<Object>();

  if (!isReleaseMode) {
    final owwnCodingClient = OWWNCodingNetworkingClient();
    final sharedPreferences = await SharedPreferences.getInstance();

    vault.store<AuthenticationRepository>(
      OWWNAuthenticationRepository(
        client: owwnCodingClient,
      ),
    );

    vault.store<DeviceRepository>(
      SharedPreferencesDeviceRepository(
        sharedPreferences: sharedPreferences,
      ),
    );

    vault.store<UsersRepository>(
      OWWNUsersRepository(
        client: owwnCodingClient,
      ),
    );
  } else {
    vault.store<AuthenticationRepository>(
      FakeAuthenticationRepository(),
    );

    vault.store<DeviceRepository>(
      FakeDeviceRepository(),
    );

    vault.store<UsersRepository>(
      FakeUsersRepository(),
    );
  }

  return vault;
}
