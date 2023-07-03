import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/presentation/screens/all_tasks/all_tasks.dart';
import 'package:todo/presentation/screens/task_detail/task_detail.dart';
import 'package:todo/domain/bloc/task_detail_screen/task_detail_screen_bloc.dart';
import 'my_logger.dart';

class Navigation extends StatelessWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final bloc = context.read<TaskDetailScreenBloc>();
    return BlocBuilder<TaskDetailScreenBloc, TaskDetailScreenState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            const MaterialPage(child: AllTasksScreen()),
            if (state.editedTask != null)
              const MaterialPage(child: TaskDetailScreen())
          ],
          onPopPage: (route, result) {
            MyLogger.log('onPopPage');
            //bloc.add(const FinishEditingEvent());
            return route.didPop(result);
          },
        );
      },
    );
  }
}
