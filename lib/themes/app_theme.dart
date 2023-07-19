import 'package:flutter/material.dart';

import 'colors_palette.dart';
import 'text_styles.dart';
import 'theme_style.dart';

class AppTheme {
  static ThemeData get lightTheme =>
      ThemeData.light(useMaterial3: false).copyWith(
        brightness: Brightness.light,
        scaffoldBackgroundColor: lightPalette.backPrimary,
        extensions: [
          ThemeStyle(
            colors: lightPalette,
            styles: textStyles,
            brightness: Brightness.dark,
          ),
        ],
      );

  static ThemeData get darkTheme =>
      ThemeData.dark(useMaterial3: false).copyWith(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: darkPalette.backPrimary,
        extensions: [
          ThemeStyle(
            colors: darkPalette,
            styles: textStyles,
            brightness: Brightness.light,
          ),
        ],
      );

  static const ColorsPalette lightPalette = ColorsPalette(
    supportSeparator: Color(0x33000000),
    supportOverlay: Color(0x0F000000),
    labelPrimary: Color(0xFF000000),
    labelSecondary: Color(0x99000000),
    labelTertiary: Color(0x4D000000),
    labelDisable: Color(0x26000000),
    red: Color(0xFFFF3B30),
    green: Color(0xFF34C759),
    blue: Color(0xFF007AFF),
    gray: Color(0xFF8E8E93),
    grayLight: Color(0xFFD1D1D6),
    white: Color(0xFFFFFFFF),
    backPrimary: Color(0xFFF7F6F2),
    backSecondary: Color(0xFFFFFFFF),
    backElevated: Color(0xFFFFFFFF),
  );

  static const ColorsPalette darkPalette = ColorsPalette(
    supportSeparator: Color(0x33FFFFFF),
    supportOverlay: Color(0x52000000),
    labelPrimary: Color(0xFFFFFFFF),
    labelSecondary: Color(0x99FFFFFF),
    labelTertiary: Color(0x66FFFFFF),
    labelDisable: Color(0x26FFFFFF),
    red: Color(0xFFFF453A),
    green: Color(0xFF32D74B),
    blue: Color(0xFF0A84FF),
    gray: Color(0xFF8E8E93),
    grayLight: Color(0xFF48484A),
    white: Color(0xFFFFFFFF),
    backPrimary: Color(0xFF161618),
    backSecondary: Color(0xFF252528),
    backElevated: Color(0xFF3C3C3F),
  );

  static const TextStyles textStyles = TextStyles(
    largeTitle: RobotoStyle.largeTitle,
    title: RobotoStyle.title,
    button: RobotoStyle.button,
    body: RobotoStyle.body,
    subhead: RobotoStyle.subhead,
  );
}
