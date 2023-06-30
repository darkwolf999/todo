import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/bloc/all_tasks_screen/all_tasks_screen_bloc.dart';
import 'package:todo/constants.dart' as Constants;
import 'package:todo/presentation/screens/all_tasks/widgets/task.dart';
import 'package:todo/presentation/widgets/svg.dart';

class TasksListview extends StatelessWidget {
  const TasksListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AllTasksScreenBloc>();
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: bloc.state.filteredTasks.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(
              bloc.state.filteredTasks[index].uuid,
            ),
            confirmDismiss: (direction) =>
                confirmDismissing(direction, bloc, index),
            onDismissed: (_) => bloc.add(
              DeleteTaskEvent(
                bloc.state.filteredTasks[index].uuid,
              ),
            ),
            background: Container(
              color: Color(
                (bloc.state.filteredTasks[index].isDone)
                    ? Constants.lightColorGrayLight
                    : Constants.lightColorGreen,
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 24.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SVG(
                    imagePath: Constants.check,
                    color: Constants.lightColorWhite,
                  ),
                ),
              ),
            ),
            secondaryBackground: Container(
              color: const Color(Constants.lightColorRed),
              child: const Padding(
                padding: EdgeInsets.only(right: 24.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SVG(
                    imagePath: Constants.delete,
                    color: Constants.lightColorWhite,
                  ),
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                top: index == 0 ? 20.0 : 12.0,
                right: 16.0,
                bottom: 12.0,
              ),
              child: Task(task: bloc.state.filteredTasks[index]),
            ),
          );
        },
      ),
    );
  }

  Future<bool> confirmDismissing(
    DismissDirection direction,
    AllTasksScreenBloc bloc,
    int index,
  ) async {
    if (direction == DismissDirection.startToEnd) {
      bloc.add(
        CompleteTaskEvent(
          bloc.state.filteredTasks[index],
        ),
      );
    }
    return direction == DismissDirection.endToStart;
  }
}
