import 'package:owwn_coding_challenge/blocs/blocs.dart';
import 'package:owwn_coding_challenge/core/core.dart';
import 'package:owwn_coding_challenge/data/data.dart';
import 'package:owwn_coding_challenge/models/models.dart';
import 'package:owwn_coding_challenge/presentation/presentation.dart';

class SplashPage extends MaterialPage {
  SplashPage()
      : super(
          child: BlocListener<AppBloc, AppState>(
            listener: (context, state) {
              final appNavigator = AppNavigator.of(context);

              if (state.isAuthenticated) {
                appNavigator.setNewRoute(
                  const UsersPageArguments(),
                );
              } else {
                appNavigator.setNewRoute(
                  const AuthenticationPageArguments(),
                );
              }
            },
            child: const SplashView(),
          ),
        );
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
            child: MultiBlocListener(
              listeners: [
                BlocListener<UsersBloc, UsersState>(
                  listener: (context, state) {
                    if (state is FetchUsersFailure &&
                        state.error is InvalidSessionAuthenticationError) {
                      final appBloc = context.read<AppBloc>();

                      appBloc.add(
                        RefreshSessionStarted(),
                      );
                    }
                  },
                ),
                BlocListener<AppBloc, AppState>(
                  listener: (context, state) {
                    if (state is AppRefresh) {
                      final usersBloc = context.read<UsersBloc>();

                      usersBloc.add(
                        FetchUsersEvent(),
                      );
                    } else if (state is RefreshSessionFailure) {
                      final appNavigator = AppNavigator.of(context);

                      appNavigator.setNewRoute(
                        const AuthenticationPageArguments(),
                      );
                    }
                  },
                ),
              ],
              child: const UsersView(),
            ),
          ),
        );
}

class UserPage extends MaterialPage {
  UserPage({
    required final UserPageArguments arguments,
  }) : super(
          child: BlocProvider(
            lazy: false,
            create: (context) => UserBloc(
              usersRepository: context.read<Vault>().lookup<UsersRepository>()
                  as UsersRepository,
              user: arguments.user,
            ),
            child: BlocListener<UserBloc, UserState>(
              listener: (context, state) {
                if (state is UserSaveSuccess) {
                  final usersBloc = arguments.usersBloc;

                  usersBloc.add(
                    RefreshUserEvent(user: state.user),
                  );
                }
              },
              child: const UserView(),
            ),
          ),
        );
}
