import 'package:owwn_coding_challenge/blocs/blocs.dart';
import 'package:owwn_coding_challenge/presentation/presentation.dart';

class AuthenticationView extends StatelessWidget {
  const AuthenticationView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authenticationBloc = context.read<AuthenticationBloc>();
    final localizations = AppLocalizations.of(context);

    final emailTextEditingController = TextEditingController();

    return Scaffold(
      body: Column(
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
          ElevatedButton(
            child: Text(
              localizations.authenticate,
            ),
            onPressed: () {
              authenticationBloc.add(
                AuthenticationEvent(
                  email: emailTextEditingController.text,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
