import 'package:flutter/material.dart';

import 'package:todo/presentation/widgets/color_svg.dart';

class CheckButton extends StatelessWidget {
  final String imagePath;
  final Color? color;
  final VoidCallback onTap;

  const CheckButton({
    Key? key,
    required this.imagePath,
    this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      splashRadius: 18.0,
      onPressed: onTap,
      icon: ColorSVG(
        imagePath: imagePath,
        color: color,
      ),
    );
  }
}
