import 'package:owwn_coding_challenge/models/user.dart';
import 'package:owwn_coding_challenge/presentation/presentation.dart';

const _tileAvatarRadius = 19.0;
const _profileAvatarRadius = 55.0;

class UserAvatar extends StatelessWidget {
  final User user;

  final double radius;

  const UserAvatar({
    required this.user,
    this.radius = _profileAvatarRadius,
    super.key,
  });

  const UserAvatar.tile({
    required final User user,
  }) : this(user: user, radius: _tileAvatarRadius);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child: Text(
        user.initials,
      ),
    );
  }
}
