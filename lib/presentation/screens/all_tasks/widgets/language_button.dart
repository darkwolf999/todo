import 'package:flutter/material.dart';

import 'package:todo/extensions/build_context_ext.dart';

class LanguageButton extends StatelessWidget {
  final VoidCallback onTap;

  const LanguageButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 24.0,
      onPressed: onTap,
      icon: Icon(Icons.language, color: context.colors.blue),
    );
  }
}
