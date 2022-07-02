import 'package:owwn_coding_challenge/presentation/presentation.dart';

void showTextSnackbar(final BuildContext context, final String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
