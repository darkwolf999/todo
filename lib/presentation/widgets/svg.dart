import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SVG extends StatelessWidget {
  final String imagePath;
  final int color;
  const SVG({
    Key? key,
    required this.imagePath,
    required this.color,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      this.imagePath,
      fit: BoxFit.scaleDown,
      colorFilter: ColorFilter.mode(
        Color(this.color),
        BlendMode.srcIn
      ),
    );
  }
}
