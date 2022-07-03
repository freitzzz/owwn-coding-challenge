import 'package:owwn_coding_challenge/presentation/presentation.dart';

const _usersCoverAssetImagePath = 'assets/images/users_cover.png';

class UsersCover extends StatelessWidget {
  const UsersCover({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      _usersCoverAssetImagePath,
      fit: BoxFit.cover,
    );
  }
}
