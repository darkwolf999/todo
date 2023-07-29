import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/extensions/build_context_ext.dart';
import 'package:todo/l10n/locale_keys.g.dart';
import 'package:todo/domain/bloc/all_tasks_screen/all_tasks_screen_bloc.dart';

class AddNewTaskButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddNewTaskButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AllTasksScreenBloc>();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 8.0,
          top: bloc.state.filteredTasks.isEmpty ? 8.0 : 0,
        ),
        height: 48.0,
        decoration: const BoxDecoration(),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  color: context.colors.labelTertiary,
                ),
                // const SVG(
                //   imagePath: Constants.add,
                //   color: Constants.lightLabelTertiary,
                // ),
                const SizedBox(width: 12.0),
                Text(
                  //Новое
                  LocaleKeys.newTask.tr(),
                  style: context.textStyles.body.copyWith(
                    color: context.colors.labelTertiary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
