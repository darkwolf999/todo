import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:todo/bloc/all_tasks_screen/all_tasks_screen_bloc.dart';
import 'package:todo/constants.dart' as Constants;
import 'package:todo/presentation/widgets/svg.dart';
import 'package:todo/presentation/models/tasks_filter.dart';

class LanguageButton extends StatelessWidget {
  final VoidCallback onTap;

  const LanguageButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 24.0,
      onPressed: onTap,
      icon: Icon(Icons.language, color: Color(Constants.lightColorBlue)),
    );
  }
}
