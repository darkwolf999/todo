import 'package:flutter/material.dart';

import 'package:todo/themes/colors_palette.dart';
import 'package:todo/themes/text_styles.dart';
import 'package:todo/themes/theme_style.dart';

extension BuildContextExt on BuildContext {
  ColorsPalette get colors => Theme.of(this).extension<ThemeStyle>()!.colors;

  TextStyles get textStyles => Theme.of(this).extension<ThemeStyle>()!.styles;

  Brightness get brightness =>
      Theme.of(this).extension<ThemeStyle>()!.brightness;
}
