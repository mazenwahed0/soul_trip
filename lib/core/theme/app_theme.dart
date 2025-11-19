import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_style.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData mainTheme = ThemeData(
    scaffoldBackgroundColor: ColorTheme().backgroundWhite,
    primaryColor: ColorTheme().primaryBlue,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorTheme().primaryBlue,
      primary: ColorTheme().primaryBlue,
      secondary: ColorTheme().primaryYellow,
    ),
  );
}
