import 'package:todo/domain/models/task_model.dart';
import 'package:todo/navigation/manager/tasks_navigation.dart';
import 'package:todo/navigation/tasks_router_delegate.dart';

class TasksNavigationImpl implements TasksNavigation {
  final TasksRouterDelegate _tasksRouterDelegate;

  TasksNavigationImpl({
    required TasksRouterDelegate tasksRouterDelegate,
  }) : _tasksRouterDelegate = tasksRouterDelegate;

  @override
  void gotoTasks() {
    _tasksRouterDelegate.gotoTasks();
  }

  @override
  void gotoTask(TaskModel? task) {
    _tasksRouterDelegate.gotoTask(task);
  }

  @override
  void pop([Object? result]) {
    _tasksRouterDelegate.pop(result);
  }
}
