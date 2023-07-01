import 'package:flutter/material.dart';

import 'package:todo/presentation/screens/all_tasks/all_tasks.dart';
import 'package:todo/presentation/screens/task_detail/task_detail.dart';
import 'navigation_state_dto.dart';
import 'navigaton_state.dart';

class TasksRouterDelegate extends RouterDelegate<NavigationStateDTO>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationStateDTO> {
  NavigationState state = NavigationState(true, null);

  bool get isAllTasksPage => state.isAllTasksPage;

  bool get isTaskDetails => !state.isAllTasksPage && state.taskId != null;

  void gotoTasks() {
    state.isAllTasksPage = true;
    notifyListeners();
  }

  void gotoTask() {
    state.isAllTasksPage = false;
    notifyListeners();
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
        if (state.isAllTasksPage == false) {
          gotoTasks();
        }
        return true;
      },
      key: navigatorKey,
      pages: [
        if (state.isAllTasksPage)
          const MaterialPage(child: AllTasksScreen()),
        if (!state.isAllTasksPage)
          const MaterialPage(child: TaskDetailScreen()),
      ],
    );
  }

  @override
  NavigationStateDTO? get currentConfiguration {
    return NavigationStateDTO(state.isAllTasksPage, state.taskId);
  }

  @override
  final GlobalKey<NavigatorState>? navigatorKey = GlobalKey();

  @override
  Future<void> setNewRoutePath(NavigationStateDTO configuration) {
    state.taskId = configuration.taskId;
    state.isAllTasksPage = configuration.allTasksPage;
    return Future.value();
  }
}