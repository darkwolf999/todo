import 'package:todo/data/models/task_model.dart';

enum TasksFilter { showAll, showOnlyActive }

extension TasksFilterExtension on TasksFilter {
  bool filterMode(TaskModel task) {
    switch (this) {
      case TasksFilter.showAll:
        return true;
      case TasksFilter.showOnlyActive:
        return !task.isDone;
    }
  }

  List<TaskModel> applyFilter(List<TaskModel> tasks) {
    return tasks.where(filterMode).toList();
  }
}
