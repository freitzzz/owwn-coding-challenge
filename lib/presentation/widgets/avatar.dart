import 'package:owwn_coding_challenge/models/user.dart';
import 'package:owwn_coding_challenge/presentation/presentation.dart';

const _tileAvatarRadius = 19.0;
const _profileAvatarRadius = 55.0;

class UserAvatar extends StatelessWidget {
  final User user;

  final double radius;

  final bool showGenderIcon;

  const UserAvatar({
    required this.user,
    this.radius = _profileAvatarRadius,
    this.showGenderIcon = true,
    super.key,
  });

  const UserAvatar.tile({
    required final User user,
  }) : this(
          user: user,
          radius: _tileAvatarRadius,
          showGenderIcon: false,
        );

  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
      radius: radius,
      child: Text(
        user.initials,
        style: TextStyle(
          fontSize: radius / 1.5,
        ),
      ),
    );

    if (showGenderIcon) {
      return LayoutBuilder(
        builder: (context, constraints) {
          final theme = Theme.of(context);

          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              avatar,
              Positioned(
                right: (constraints.maxWidth / 2) - radius,
                child: CircleAvatar(
                  backgroundColor: theme.colorScheme.onBackground,
                  child: Center(
                    child: Icon(
                      user.gender.iconData,
                      color: theme.colorScheme.background,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      return avatar;
    }
  }
}
