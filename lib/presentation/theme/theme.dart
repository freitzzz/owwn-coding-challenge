import 'package:flutter/material.dart';

final _textThemeLight = ThemeData.light().textTheme;
final _textThemeDark = ThemeData.dark().textTheme;

const _seed = Color(0xFFDCEFD2);

final _lightColorScheme = ColorScheme.fromSeed(
  seedColor: _seed,
);

final _darkColorScheme = ColorScheme.fromSeed(
  seedColor: _seed,
  brightness: Brightness.dark,
);

final owwnCodingLightTheme = ThemeData(
  textTheme: _textThemeLight,
  useMaterial3: true,
  colorScheme: _lightColorScheme,
);

final owwnCodingDarkTheme = ThemeData(
  textTheme: _textThemeDark,
  useMaterial3: true,
  colorScheme: _darkColorScheme,
);
