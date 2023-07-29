import 'package:flutter/material.dart';

import 'colors_palette.dart';
import 'text_styles.dart';

class ThemeStyle extends ThemeExtension<ThemeStyle> {
  ThemeStyle({
    required this.colors,
    required this.styles,
  });

  final ColorsPalette colors;
  final TextStyles styles;

  @override
  ThemeExtension<ThemeStyle> copyWith() => this;

  @override
  ThemeExtension<ThemeStyle> lerp(
    ThemeExtension<ThemeStyle>? other,
    double t,
  ) =>
      this;
}
