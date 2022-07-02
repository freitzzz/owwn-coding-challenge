class User {
  final String id;

  final String email;

  final String name;

  final Gender gender;

  final Status status;

  final List<double> statistics;

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
