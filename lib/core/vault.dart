import 'package:owwn_coding_challenge/data/data.dart';

class Vault<T> {
  final _vault = <Type, T>{};

  void store<S extends T>(final S value) => _vault[S] = value;

  T? lookup<S extends T>() => _vault[S];
}

Vault<Object> createVault({
  required final bool isReleaseMode,
}) {
  final vault = Vault<Object>();

  if (isReleaseMode) {
    final owwnCodingClient = OWWNCodingNetworkingClient();

    vault.store<AuthenticationRepository>(
      OWWNAuthenticationRepository(
        client: owwnCodingClient,
      ),
    );
  } else {
    vault.store<AuthenticationRepository>(
      FakeAuthenticationRepository(),
    );
  }

  return vault;
}
