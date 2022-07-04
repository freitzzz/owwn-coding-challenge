import 'package:owwn_coding_challenge/presentation/presentation.dart';

const _usersCoverAssetImagePath = 'assets/images/users_cover.png';
const _owwnLogoAssetImagePath = 'assets/images/owwn_logo.png';

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

class OWWNLogo extends StatelessWidget {
  const OWWNLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      _owwnLogoAssetImagePath,
      fit: BoxFit.cover,
    );
  }
}
