import 'package:owwn_coding_challenge/models/models.dart';
import 'package:owwn_coding_challenge/presentation/presentation.dart';

const _userTileCornerRadius = Radius.circular(tenPoints);

const _userTileFirstInGroupShapeBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: _userTileCornerRadius,
    topRight: _userTileCornerRadius,
  ),
);

const _userTileLastInGroupShapeBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    bottomLeft: _userTileCornerRadius,
    bottomRight: _userTileCornerRadius,
  ),
);

class UserListTile extends StatelessWidget {
  final bool isFirstInGroup;

  final bool isLastInGroup;

  final User user;

  final VoidCallback onTap;

  const UserListTile({
    super.key,
    required this.user,
    required this.onTap,
    this.isFirstInGroup = false,
    this.isLastInGroup = false,
  });

  @override
  Widget build(BuildContext context) {
    ShapeBorder? shapeBorder;

    if (isFirstInGroup) {
      shapeBorder = _userTileFirstInGroupShapeBorder;
    } else if (isLastInGroup) {
      shapeBorder = _userTileLastInGroupShapeBorder;
    }

    return ListTile(
      shape: shapeBorder,
      title: Text(user.name),
      subtitle: Text(user.email),
      leading: UserAvatar.tile(
        user: user,
      ),
      onTap: onTap,
    );
  }
}
