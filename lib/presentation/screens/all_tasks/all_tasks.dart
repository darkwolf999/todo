import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/bloc/all_tasks_screen/all_tasks_screen_bloc.dart';
import 'package:todo/constants.dart' as Constants;
import 'package:todo/presentation/screens/all_tasks/widgets/add_new_task_button.dart';
import 'package:todo/presentation/screens/all_tasks/widgets/custom_sliver_appbar.dart';
import 'package:todo/presentation/screens/all_tasks/widgets/custom_slivertobox_adapter.dart';
import 'package:todo/presentation/screens/all_tasks/widgets/tasks_listview.dart';
import 'package:todo/presentation/screens/task_detail/task_detail.dart';
import 'package:todo/repositories/tasks_repository.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AllTasksScreenBloc>(
      create: (context) => AllTasksScreenBloc(
        context.read<TasksRepository>(),
      )..add(const SubscribeStreamEvent()),
      child: const AllTasksScreenContent(),
    );
  }
}

class AllTasksScreenContent extends StatelessWidget {
  const AllTasksScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(Constants.lightBackPrimary),
      body: BlocBuilder<AllTasksScreenBloc, AllTasksScreenState>(
        builder: (context, state) {
          return CustomScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              CustomSliverAppbar(),
              CustomSliverToBoxAdapter(),
              SliverPadding(
                padding: const EdgeInsets.only(
                  left: 4.0,
                  right: 4.0,
                  bottom: 3.0,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Card(
                        color: const Color(Constants.lightBackSecondary),
                        semanticContainer: false,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        elevation: 4.0,
                        child: Column(
                          children: [
                            TasksListview(),
                            AddNewTaskButton(
                              onTap: () {
                                addNewTask(scrollController, context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: 1,
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNewTask(scrollController, context);
        },
        backgroundColor: const Color(Constants.lightColorBlue),
        tooltip: 'Добавить дело',
        child: const Icon(Icons.add),
      ),
    );
  }

  void addNewTask(
    ScrollController scrollController,
    BuildContext context,
  ) async {
    final animateScrollTop = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TaskDetailScreen(),
      ),
    );
    if (animateScrollTop) {
      scrollController.animateTo(
        0,
        duration: const Duration(
          milliseconds: 500,
        ),
        curve: Curves.linear,
      );
    }
  }
}
