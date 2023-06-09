import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/domain/bloc/all_tasks_screen/all_tasks_screen_bloc.dart';
import 'package:todo/constants.dart' as Constants;
import 'package:todo/domain/models/task_model.dart';
import 'package:todo/presentation/widgets/svg.dart';
import 'package:todo/helpers/format_date.dart';
import 'package:todo/navigation/tasks_router_delegate.dart';
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
    final router = Router.of(context).routerDelegate as TasksRouterDelegate;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (task.isDone) ...[
          CheckButton(
            imagePath: Constants.checkboxChecked,
            onTap: () {
              bloc.add(CompleteTaskEvent(task));
            },
          ),
        ] else ...[
          if (task.priority == Priority.high) ...[
            CheckButton(
              imagePath: Constants.checkboxUncheckedHigh,
              onTap: () {
                bloc.add(CompleteTaskEvent(task));
              },
            ),
          ] else ...[
            CheckButton(
              imagePath: Constants.checkboxUncheckedNormal,
              onTap: () {
                bloc.add(CompleteTaskEvent(task));
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
                ? const SVG(
                    imagePath: Constants.priorityHigh,
                    color: Constants.lightColorRed,
                  )
                : const SVG(
                    imagePath: Constants.priorityLow,
                    color: Constants.lightColorGray,
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
                  style: const TextStyle(
                    color: Color(Constants.lightLabelTertiary),
                    decoration: TextDecoration.lineThrough,
                    fontSize: Constants.bodyFontSize,
                    height: Constants.bodyFontHeight,
                  ),
                ),
              ] else ...[
                Text(
                  task.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(Constants.lightLabelPrimary),
                    decoration: TextDecoration.none,
                    fontSize: Constants.bodyFontSize,
                    height: Constants.bodyFontHeight,
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
                    style: const TextStyle(
                      color: Color(Constants.lightLabelTertiary),
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
            router.gotoTask(task);
          },
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: const SVG(
            imagePath: Constants.infoOutlined,
            color: Constants.lightLabelTertiary,
          ),
        )
      ],
    );
  }
}
