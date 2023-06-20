import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SVG extends StatelessWidget {
  final String imagePath;
  final int? color;

  const SVG({
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
              Color(color!),
              BlendMode.srcIn,
            ),
          )
        : SvgPicture.asset(
            imagePath,
            fit: BoxFit.scaleDown,
          );
  }
}
