import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/bloc/all_tasks_screen/all_tasks_screen_bloc.dart';
import 'package:todo/constants.dart' as Constants;
import 'package:todo/presentation/widgets/svg.dart';
import 'package:todo/presentation/models/tasks_filter.dart';

class VisibilityButton extends StatelessWidget {
  const VisibilityButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AllTasksScreenBloc>();
    return IconButton(
      splashRadius: 24.0,
      onPressed: () {
        bloc.add(
          ChangeFilterEvent(
            bloc.state.filter == TasksFilter.showAll
                ? TasksFilter.showOnlyActive
                : TasksFilter.showAll,
          ),
        );
      },
      icon: SVG(
        imagePath: bloc.state.filter != TasksFilter.showAll
            ? Constants.visibilityOff
            : Constants.visibility,
      ),
    );
  }
}
