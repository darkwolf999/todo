import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/domain/bloc/all_tasks_screen/all_tasks_screen_bloc.dart';
import 'package:todo/extensions/build_context_ext.dart';
import 'package:todo/presentation/screens/all_tasks/widgets/tasks_listview.dart';
import 'package:todo/presentation/models/tasks_filter.dart';

class VisibilityButton extends StatelessWidget {
  const VisibilityButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AllTasksScreenBloc>();
    return IconButton(
      splashRadius: 24.0,
      onPressed: () {
        List<int> indexes = [];
        for (int i = 0; i < bloc.state.tasks!.length; i++) {
          if (bloc.state.tasks?[i].isDone == true) {
            indexes.add(i);
          }
        }

        Iterable<int> revIndexes = indexes.reversed;

        bloc.state.filter == TasksFilter.showAll
            ? {
                bloc.add(
                  const ChangeFilterEvent(
                    TasksFilter.showOnlyActive,
                  ),
                ),
                for (var task in revIndexes)
                  {
                    listKey.currentState?.removeItem(
                      task,
                      (context, animation) {
                        return Container();
                      },
                    ),
                  },
              }
            : {
                bloc.add(
                  const ChangeFilterEvent(
                    TasksFilter.showAll,
                  ),
                ),
                for (var task in indexes)
                  {
                    listKey.currentState?.insertItem(task),
                  },
              };
      },
      icon: Icon(
        bloc.state.filter != TasksFilter.showAll
            ? Icons.visibility_off
            : Icons.visibility,
        color: context.colors.blue,
      ),
      //color: context.colors.blue,
    );
  }
}
