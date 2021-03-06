import 'package:owwn_coding_challenge/presentation/presentation.dart';
import 'package:owwn_coding_challenge/presentation/routing/pages.dart';

export 'arguments.dart';

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
  PageArguments arguments = const SplashPageArguments();

  @override
  Widget build(BuildContext context) {
    final arguments = this.arguments;

    return Navigator(
      pages: [
        if (arguments is SplashPageArguments) SplashPage(),
        if (arguments is AuthenticationPageArguments) AuthenticationPage(),
        if (arguments is UsersPageArguments || arguments is UserPageArguments)
          UsersPage(),
        if (arguments is UserPageArguments)
          UserPage(
            arguments: arguments,
          ),
      ],
      onPopPage: (route, result) => route.didPop(result),
    );
  }

  void setNewRoute(final PageArguments arguments) {
    setState(
      () {
        this.arguments = arguments;
      },
    );
  }
}
