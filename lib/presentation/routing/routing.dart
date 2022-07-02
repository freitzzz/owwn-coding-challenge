import 'package:owwn_coding_challenge/blocs/blocs.dart';
import 'package:owwn_coding_challenge/core/core.dart';
import 'package:owwn_coding_challenge/data/data.dart';
import 'package:owwn_coding_challenge/presentation/presentation.dart';

final appNavigator = Navigator(
  pages: [
    AuthenticationPage(),
  ],
  onPopPage: (route, result) => route.didPop(result),
);

class AuthenticationPage extends MaterialPage {
  AuthenticationPage()
      : super(
          child: BlocProvider(
            create: (context) => AuthenticationBloc(
              authenticationRepository:
                  context.read<Vault>().lookup<AuthenticationRepository>()
                      as AuthenticationRepository,
            ),
            child: const AuthenticationView(),
          ),
        );
}
