import 'package:owwn_coding_challenge/blocs/blocs.dart';
import 'package:owwn_coding_challenge/presentation/presentation.dart';

class AuthenticationView extends StatelessWidget {
  const AuthenticationView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppBloc>();
    final authenticationBloc = context.read<AuthenticationBloc>();
    final localizations = AppLocalizations.of(context);

    final emailTextEditingController = TextEditingController();

    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationFailure) {
            showTextSnackbar(
              context,
              localizations.authenticationError(state.error),
            );
          } else if (state is AuthenticationSuccess) {
            appBloc.add(
              AppAuthenticated(session: state.session),
            );

            AppNavigator.of(context).setNewRoute(usersRoute);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: sixteenPoints,
              ),
              child: TextFormField(
                controller: emailTextEditingController,
                decoration: InputDecoration(
                  labelText: localizations.email,
                ),
              ),
            ),
            const SizedBox.square(
              dimension: thirtyTwoPoints,
            ),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: _onAuthenticateButtonPressed(
                    authenticationBloc,
                    emailTextEditingController,
                  ),
                  child: Text(localizations.authenticate),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  VoidCallback? _onAuthenticateButtonPressed(
    final AuthenticationBloc authenticationBloc,
    final TextEditingController emailTextEditingController,
  ) {
    VoidCallback? callback;

    if (authenticationBloc.state is! AuthenticationInProgress) {
      callback = () {
        authenticationBloc.add(
          AuthenticationEvent(
            email: emailTextEditingController.text,
          ),
        );
      };
    }

    return callback;
  }
}
