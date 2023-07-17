import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ColorSVG extends StatelessWidget {
  final String imagePath;
  final Color? color;

  const ColorSVG({
    Key? key,
    required this.imagePath,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return color != null
        ? SvgPicture.asset(
            imagePath,
            fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(
              color!,
              BlendMode.srcIn,
            ),
          )
        : SvgPicture.asset(
            imagePath,
            fit: BoxFit.scaleDown,
          );
  }
}
