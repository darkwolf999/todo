import 'package:todo/domain/models/task_model.dart';

abstract class TasksNavigation {
  void gotoTasks();

  void gotoTask(TaskModel? task, int? taskIndex);

  void pop([Object? result]);
}
