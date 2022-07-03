class User {
  final String id;

  final String email;

  final String name;

  final Gender gender;

  final Status status;

  final List<double> statistics;

  String get initials {
    final nameSplit = name.split(' ');

    if (nameSplit.length >= 2) {
      return '${nameSplit.first[0]}${nameSplit.last[0]}'.toUpperCase();
    } else if (name.length >= 2) {
      return '${name[0]}${name[1]}'.toUpperCase();
    } else {
      return '';
    }
  }

  bool get active => status == Status.active;

  bool get hasStatistics => statistics.isNotEmpty;

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.gender,
    required this.status,
    required this.statistics,
  });

  User.fromJson(
    final Map<String, dynamic> json, {
    final bool skipEmail = true,
  })  : email = !skipEmail ? json['id'] as String : 'unknown@owwn.com',
        id = json['id'] as String,
        gender = Gender.parse(json['gender'] as String),
        status = Status.parse(json['status'] as String),
        name = json['name'] as String,
        statistics = List.from(
          (json['statistics'] ?? []) as List<dynamic>,
        );
}

enum Gender {
  male,
  female,
  other;

  static Gender parse(final String value) {
    switch (value.toLowerCase()) {
      case 'male':
        return male;
      case 'female':
        return female;
      case 'other':
      default:
        return other;
    }
  }
}

enum Status {
  active,
  inactive;

  static Status parse(final String value) {
    switch (value.toLowerCase()) {
      case 'active':
        return active;
      case 'inactive':
      default:
        return inactive;
    }
  }
}

List<User> parseUsersJson(
  final Map<String, dynamic> json,
) {
  final users =
      (json['users'] ?? <Map<String, dynamic>>[]) as List<Map<String, dynamic>>;

  return users.map(User.fromJson).toList();
}
