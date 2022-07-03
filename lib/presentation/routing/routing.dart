import 'package:owwn_coding_challenge/presentation/presentation.dart';
import 'package:owwn_coding_challenge/presentation/routing/pages.dart';

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
        const UserPage(),
        // if (route == authenticationRoute) AuthenticationPage(),
        // if (route == usersRoute) UsersPage(),
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
