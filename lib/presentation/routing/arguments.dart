import 'package:owwn_coding_challenge/models/models.dart';
import 'package:owwn_coding_challenge/presentation/routing/routes.dart';

abstract class PageArguments {
  final String route;

  const PageArguments({
    required this.route,
  });
}

class AuthenticationPageArguments extends PageArguments {
  const AuthenticationPageArguments() : super(route: authenticationRoute);
}

class UsersPageArguments extends PageArguments {
  const UsersPageArguments() : super(route: usersRoute);
}

class UserPageArguments extends PageArguments {
  final User user;

  const UserPageArguments({
    required this.user,
  }) : super(route: userRoute);
}
