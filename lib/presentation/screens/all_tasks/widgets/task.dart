import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/domain/bloc/all_tasks_screen/all_tasks_screen_bloc.dart';
import 'package:todo/constants.dart' as Constants;
import 'package:todo/domain/bloc/firebase/remote_config/remote_config_bloc.dart';
import 'package:todo/domain/models/task_model.dart';
import 'package:todo/extensions/build_context_ext.dart';
import 'package:todo/presentation/models/tasks_filter.dart';
import 'package:todo/presentation/screens/all_tasks/widgets/tasks_listview.dart';
import 'package:todo/helpers/format_date.dart';
import 'package:todo/navigation/manager/tasks_navigation.dart';
import 'package:todo/presentation/widgets/color_svg.dart';
import 'check_button.dart';

class Task extends StatelessWidget {
  final TaskModel task;

  const Task({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AllTasksScreenBloc>();
    //final router = Router.of(context).routerDelegate as TasksRouterDelegate;
    final router = context.read<TasksNavigation>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (task.isDone) ...[
          CheckButton(
            imagePath: Constants.checkboxChecked,
            color: context.colors.green,
            onTap: () {
              bloc.add(CompleteTaskEvent(task));
            },
          ),
        ] else ...[
          if (task.priority == Priority.high) ...[
            BlocBuilder<RemoteConfigBloc, RemoteConfigState>(
              builder: (context, state) {
                return CheckButton(
                  imagePath: Constants.checkboxUncheckedHigh,
                  color: state.highPriorityColor != null
                      ? Color(state.highPriorityColor!)
                      : context.colors.red,
                  onTap: () {
                    bloc.add(CompleteTaskEvent(task));
                    if (bloc.state.filter == TasksFilter.showOnlyActive) {
                      final taskIndex = bloc.state.filteredTasks.indexWhere(
                        (t) => t.uuid == task.uuid,
                      );
                      listKey.currentState?.removeItem(taskIndex,
                          (context, animation) {
                        return Container();
                      });
                    }
                  },
                );
              },
            ),
          ] else ...[
            CheckButton(
              imagePath: Constants.checkboxUncheckedNormal,
              color: context.colors.supportSeparator,
              onTap: () {
                bloc.add(CompleteTaskEvent(task));
                if (bloc.state.filter == TasksFilter.showOnlyActive) {
                  final taskIndex = bloc.state.filteredTasks.indexWhere(
                    (t) => t.uuid == task.uuid,
                  );
                  listKey.currentState?.removeItem(taskIndex,
                      (context, animation) {
                    return Container();
                  });
                }
              },
            ),
          ]
        ],
        const SizedBox(width: 12),
        Visibility(
          visible: !(task.isDone) &&
              (task.priority == Priority.high || task.priority == Priority.low),
          child: Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: task.priority == Priority.high
                ? BlocBuilder<RemoteConfigBloc, RemoteConfigState>(
                    builder: (context, state) {
                      return ColorSVG(
                        imagePath: Constants.priorityHigh,
                        color: state.highPriorityColor != null
                            ? Color(state.highPriorityColor!)
                            : context.colors.red,
                      );
                    },
                  )
                : ColorSVG(
                    imagePath: Constants.priorityLow,
                    color: context.colors.gray,
                  ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (task.isDone) ...[
                Text(
                  task.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: context.textStyles.body.copyWith(
                    color: context.colors.labelTertiary,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ] else ...[
                Text(
                  task.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: context.textStyles.body.copyWith(
                    color: context.colors.labelPrimary,
                  ),
                ),
              ],
              Visibility(
                visible: task.deadline != null,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    FormatDate.toDmmmmyyyy(
                      task.deadline ?? DateTime.now(),
                      Localizations.localeOf(context).toString(),
                    ),
                    style: context.textStyles.subhead.copyWith(
                      color: context.colors.labelTertiary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12.0),
        IconButton(
          onPressed: () {
            final taskIndex = bloc.state.filteredTasks.indexWhere(
              (t) => t.uuid == task.uuid,
            );
            router.gotoTask(task, taskIndex);
          },
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: Icon(
            Icons.info_outline,
            color: context.colors.labelTertiary,
          ),
        )
      ],
    );
  }
}
