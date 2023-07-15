import 'package:flutter/material.dart';
import 'package:todo/data/api/constants/api_constants.dart';

import 'package:todo/presentation/screens/all_tasks/all_tasks.dart';
import 'package:todo/presentation/screens/task_detail/task_detail.dart';
import 'package:todo/domain/models/task_model.dart';
import 'package:todo/data/api/analytics_provider.dart';
import 'navigation_state_dto.dart';
import 'navigaton_state.dart';

class TasksRouterDelegate extends RouterDelegate<NavigationStateDTO>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationStateDTO> {
  final AnalyticsProvider _analyticsProvider;

  TasksRouterDelegate({
    required AnalyticsProvider analyticsProvider,
  }) : _analyticsProvider = analyticsProvider;

  NavigationState state = NavigationState(true, null);

  bool get isAllTasksPage => state.isAllTasksPage;

  bool get isTaskDetails => !state.isAllTasksPage && state.task != null;

  void gotoTasks() async {
    state.isAllTasksPage = true;
    notifyListeners();
    await _analyticsProvider.logScreenView(ApiConstants.allTasksScreen);
  }

  void gotoTask(TaskModel? task) async {
    state.isAllTasksPage = false;
    state.task = task;
    notifyListeners();
    await _analyticsProvider.logScreenView(ApiConstants.taskDetailScreen);
  }

  void pop([Object? result]) {
    navigatorKey?.currentState?.pop(result);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        if (!state.isAllTasksPage) {
          gotoTasks();
        }
        return true;
      },
      key: navigatorKey,
      pages: [
        const MaterialPage(child: AllTasksScreen()),
        if (!state.isAllTasksPage)
          //bloc.add(StartEditingTaskEvent()),
          MaterialPage(child: TaskDetailScreen(task: state.task)),
      ],
    );
  }

  @override
  NavigationStateDTO? get currentConfiguration {
    return NavigationStateDTO(state.isAllTasksPage, state.task);
  }

  @override
  final GlobalKey<NavigatorState>? navigatorKey = GlobalKey();

  @override
  Future<void> setNewRoutePath(NavigationStateDTO configuration) {
    state.task = configuration.task;
    state.isAllTasksPage = configuration.allTasksPage;
    return Future.value();
  }
}
