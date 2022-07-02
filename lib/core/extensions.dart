import 'dart:convert';

extension MapExtension on Map {
  String get encode => jsonEncode(this);
}
