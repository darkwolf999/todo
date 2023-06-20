import 'package:flutter/material.dart';

import 'package:todo/presentation/widgets/svg.dart';

class CheckButton extends StatelessWidget {
  final String imagePath;
  final int? color;
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
      icon: SVG(
        imagePath: imagePath,
        color: color,
      ),
    );
  }
}
