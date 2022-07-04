import 'package:owwn_coding_challenge/blocs/blocs.dart';
import 'package:owwn_coding_challenge/core/core.dart';
import 'package:owwn_coding_challenge/data/data.dart';
import 'package:owwn_coding_challenge/presentation/presentation.dart';

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
