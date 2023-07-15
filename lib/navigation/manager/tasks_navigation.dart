import 'package:todo/domain/models/task_model.dart';

abstract class TasksNavigation {
  void gotoTasks();

  void gotoTask(TaskModel? task);

  void pop([Object? result]);
}
