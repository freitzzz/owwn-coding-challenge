import 'package:flutter/material.dart';
import 'package:owwn_coding_challenge/blocs/blocs.dart';
import 'package:owwn_coding_challenge/core/core.dart';
import 'package:owwn_coding_challenge/logging/logging.dart';

void main() {
  putLumberdashToWork(
    withClients: [
      MinimalPrintLumberdashClient(),
    ],
  );

  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      final vault = await createVault(
        isReleaseMode: true,
      );

      runApp(
        OWWNCodingApp(
          vault: vault,
        ),
      );
    },
    blocObserver: LogBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Coding Challenge',
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
    );
  }
}
