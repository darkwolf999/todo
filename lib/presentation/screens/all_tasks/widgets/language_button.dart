import 'package:flutter/material.dart';

import 'package:todo/constants.dart' as Constants;

class LanguageButton extends StatelessWidget {
  final VoidCallback onTap;

  const LanguageButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 24.0,
      onPressed: onTap,
      icon: const Icon(Icons.language, color: Color(Constants.lightColorBlue)),
    );
  }
}
