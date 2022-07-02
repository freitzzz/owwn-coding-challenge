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
  } else {}

  return vault;
}
