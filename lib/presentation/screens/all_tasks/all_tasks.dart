import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/all_tasks_screen/all_tasks_screen_bloc.dart';

import 'package:todo/constants.dart' as Constants;

import 'package:todo/data/models/task_model.dart';
import 'package:todo/presentation/models/tasks_filter.dart';
import 'package:todo/presentation/screens/all_tasks/widgets/add_new_task_button.dart';
import 'package:todo/presentation/screens/all_tasks/widgets/custom_appbar.dart';
import 'package:todo/presentation/screens/all_tasks/widgets/tasks_listview.dart';
import 'package:todo/presentation/screens/task_detail/task_detail.dart';
import 'package:todo/presentation/widgets/svg.dart';
import 'dart:developer' as developer;

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
    final bloc = context.read<AllTasksScreenBloc>();
    return Scaffold(
      backgroundColor: const Color(Constants.lightBackPrimary),
      body: BlocBuilder<AllTasksScreenBloc, AllTasksScreenState>(
        builder: (context, state) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                snap: false,
                floating: true,
                elevation: 5.0,
                expandedHeight: 88.0,
                backgroundColor: Colors.greenAccent,
                actions: [
                  IconButton(
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
                  )
                ],
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text(
                    'Мои дела',
                    style: TextStyle(
                      color: Color(Constants.lightLabelPrimary),
                      fontSize: Constants.titleFontSize,
                      height: Constants.titleFontHeight,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 60.0,
                    top: 2.0,
                    bottom: 18.0,
                  ),
                  child: SizedBox(
                    height: 24.0,
                    child: Text(
                      'Выполнено — ${bloc.state.completedTasksCount}',
                      style: const TextStyle(
                        color: Color(Constants.lightLabelTertiary),
                        fontSize: Constants.bodyFontSize,
                        height: Constants.bodyFontHeight,
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                            //TasksListview(bloc: bloc),
                            TasksListview(bloc: bloc),
                            AddNewTaskButton(
                              bloc: bloc,
                              onTap: () {
                                developer.log('adding new task');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TaskDetailScreen(),
                                  ),
                                );
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
              const SliverPadding(padding: EdgeInsets.only(bottom: 3.0)),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: () { //раскомментить потом
        //   developer.log('adding new task');
        //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
        //       TaskDetailScreen(task: TaskModel(title: '', isDone: false)),),);
        // },
        onPressed: () {
          bloc.add(
            AddTaskEvent(
              TaskModel(
                title: 'Купить что-то...',
                isDone: false,
                deadline: DateTime.now(),
              ),
            ),
          );
        },
        backgroundColor: const Color(Constants.lightColorBlue),
        tooltip: 'Добавить дело',
        child: const Icon(Icons.add),
      ),
    );
  }
}
