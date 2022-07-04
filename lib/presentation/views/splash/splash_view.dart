import 'package:owwn_coding_challenge/presentation/presentation.dart';

class SplashView extends StatelessWidget {
  const SplashView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: seedColor,
      body: Center(
        child: OWWNLogo(),
      ),
    );
  }
}
