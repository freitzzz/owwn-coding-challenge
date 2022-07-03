import 'package:owwn_coding_challenge/models/models.dart';
import 'package:owwn_coding_challenge/presentation/presentation.dart';

class UserView extends StatelessWidget {
  const UserView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const user = User(
      id: 'soheil@owwn.com',
      name: 'Soheil',
      email: 'soheil@owwn.com',
      gender: Gender.male,
      status: Status.active,
      statistics: [],
    );

    return Scaffold(
      body: ListView(
        primary: false,
        children: [
          const UserAvatar(
            user: user,
          ),
          Text(
            user.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28.0,
            ),
          ),
          Text(
            user.email,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 17.0,
            ),
          ),
        ],
      ),
    );
  }
}
