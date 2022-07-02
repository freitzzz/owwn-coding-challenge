import 'package:owwn_coding_challenge/presentation/presentation.dart';

final appNavigator = Navigator(
  pages: const [
    AuthenticationPage(),
  ],
  onPopPage: (route, result) => route.didPop(result),
);

class AuthenticationPage extends MaterialPage {
  const AuthenticationPage() : super(child: const AuthenticationView());
}
