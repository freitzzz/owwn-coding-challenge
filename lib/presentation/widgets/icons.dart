import 'package:owwn_coding_challenge/models/models.dart';
import 'package:owwn_coding_challenge/presentation/presentation.dart';

const maleIconData = Icons.male;
const femaleIconData = Icons.female;
const otherGenderIconData = Icons.question_mark;

extension GenderIconExtension on Gender {
  IconData get iconData {
    switch (this) {
      case Gender.male:
        return maleIconData;
      case Gender.female:
        return femaleIconData;
      case Gender.other:
      default:
        return otherGenderIconData;
    }
  }
}
