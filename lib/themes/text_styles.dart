import 'package:flutter/material.dart';

class TextStyles {
  const TextStyles({
    required this.largeTitle,
    required this.title,
    required this.button,
    required this.body,
    required this.subhead,
  });

  final TextStyle largeTitle;
  final TextStyle title;
  final TextStyle button;
  final TextStyle body;
  final TextStyle subhead;
}

class RobotoStyle {
  const RobotoStyle._();

  static const fontFamily = 'Roboto';

  static const double largeTitleFontSize = 32;
  static const double largeTitleFontHeight = 38 / largeTitleFontSize;
  static const largeTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: largeTitleFontSize,
    fontWeight: FontWeight.w500,
    height: largeTitleFontHeight,
  );

  static const double titleFontSize = 20;
  static const double titleFontHeight = 32 / titleFontSize;
  static const title = TextStyle(
    fontFamily: fontFamily,
    fontSize: titleFontSize,
    fontWeight: FontWeight.w500,
    height: titleFontHeight,
    //letterSpacing: 0.5,
  );

  static const double buttonFontSize = 14;
  static const double buttonFontHeight = 24 / buttonFontSize;
  static const button = TextStyle(
    fontFamily: fontFamily,
    fontSize: buttonFontSize,
    fontWeight: FontWeight.w500,
    height: buttonFontHeight,
    //letterSpacing: 0.16,
  );

  static const double bodyFontSize = 16;
  static const double bodyFontHeight = 20 / bodyFontSize;
  static const body = TextStyle(
    fontFamily: fontFamily,
    fontSize: bodyFontSize,
    fontWeight: FontWeight.w400,
    height: bodyFontHeight,
  );

  static const double subheadFontSize = 14;
  static const double subheadFontHeight = 20 / subheadFontSize;
  static const subhead = TextStyle(
    fontFamily: fontFamily,
    fontSize: subheadFontSize,
    fontWeight: FontWeight.w400,
    height: subheadFontHeight,
  );
}
