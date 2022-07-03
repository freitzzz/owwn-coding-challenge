import 'package:owwn_coding_challenge/blocs/blocs.dart';
import 'package:owwn_coding_challenge/core/core.dart';
import 'package:owwn_coding_challenge/data/data.dart';
import 'package:owwn_coding_challenge/presentation/presentation.dart';

const authenticationRoute = '/authentication';
const usersRoute = '/users';

class AppNavigator extends StatefulWidget {
  const AppNavigator({
    Key? key,
  }) : super(key: key);

  static AppNavigatorState of(final BuildContext context) {
    return context.findAncestorStateOfType<AppNavigatorState>()!;
  }

  @override
  State<AppNavigator> createState() => AppNavigatorState();
}

class AppNavigatorState extends State<AppNavigator> {
  String route = authenticationRoute;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        if (route == authenticationRoute) AuthenticationPage(),
        if (route == usersRoute) UsersPage(),
      ],
      onPopPage: (route, result) => route.didPop(result),
    );
  }

  void setNewRoute(final String route) {
    setState(
      () {
        this.route = route;
      },
    );
  }
}

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

class UsersPage extends MaterialPage {
  UsersPage()
      : super(
          child: BlocProvider(
            lazy: false,
            create: (context) => UsersBloc(
              usersRepository: context.read<Vault>().lookup<UsersRepository>()
                  as UsersRepository,
            )..add(FetchUsersEvent()),
            child: const UsersView(),
          ),
        );
}
