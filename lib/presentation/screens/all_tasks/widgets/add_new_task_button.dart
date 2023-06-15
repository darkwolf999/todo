import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/all_tasks_screen/all_tasks_screen_bloc.dart';
import 'package:todo/constants.dart' as Constants;
import 'package:todo/presentation/widgets/svg.dart';

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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: const Color(Constants.lightBackSecondary),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: const [
                SVG(
                  imagePath: Constants.add,
                  color: Constants.lightLabelTertiary,
                ),
                SizedBox(width: 12.0),
                Text(
                  'Новое',
                  style: TextStyle(
                    fontSize: Constants.bodyFontSize,
                    height: Constants.bodyFontHeight,
                    color: Color(
                      Constants.lightLabelTertiary,
                    ),
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
