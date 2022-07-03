import 'package:flutter/material.dart';

final _textThemeLight = ThemeData.light().textTheme;
final _textThemeDark = ThemeData.dark().textTheme;

const _seed = Color(0xFF2E22F7);

final _lightColorScheme = ColorScheme.fromSeed(
  seedColor: _seed,
  background: Colors.white,
);

final _darkColorScheme = ColorScheme.fromSeed(
  seedColor: _seed,
  background: Colors.black,
  brightness: Brightness.dark,
);

final owwnCodingLightTheme = ThemeData(
  textTheme: _textThemeLight,
  useMaterial3: true,
  colorScheme: _lightColorScheme,
  scaffoldBackgroundColor: _lightColorScheme.background,
);

final owwnCodingDarkTheme = ThemeData(
  textTheme: _textThemeDark,
  useMaterial3: true,
  colorScheme: _darkColorScheme,
  scaffoldBackgroundColor: _darkColorScheme.background,
  primaryColorDark: const Color(0xFF393939),
  listTileTheme: const ListTileThemeData(
    tileColor: Color(0xFF2B2B2B),
  ),
);
