import 'package:owwn_coding_challenge/blocs/blocs.dart';
import 'package:owwn_coding_challenge/core/core.dart';
import 'package:owwn_coding_challenge/data/data.dart';
import 'package:owwn_coding_challenge/presentation/presentation.dart';

class OWWNCodingApp extends StatelessWidget {
  final Vault vault;

  const OWWNCodingApp({
    Key? key,
    required this.vault,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<Vault>(
      create: (context) => vault,
      child: BlocProvider(
        lazy: false,
        create: (context) => AppBloc(
          deviceRepository:
              vault.lookup<DeviceRepository>() as DeviceRepository,
        )..add(AppStarted()),
        child: MaterialApp(
          title: 'Flutter Coding Challenge',
          theme: owwnCodingLightTheme,
          darkTheme: owwnCodingDarkTheme,
          themeMode: ThemeMode.dark,
          localizationsDelegates: const [
            AppLocalizations.delegate,
          ],
          supportedLocales: supportedLocales,
          home: appNavigator,
        ),
      ),
    );
  }
}
