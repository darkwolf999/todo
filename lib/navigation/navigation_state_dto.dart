import 'package:todo/domain/models/task_model.dart';

class NavigationStateDTO {
  bool allTasksPage;
  TaskModel? task;
  int? taskIndex;

  NavigationStateDTO(this.allTasksPage, this.task, this.taskIndex);

  NavigationStateDTO.allTasksPage()
      : allTasksPage = true,
        task = null,
        taskIndex = null;

  NavigationStateDTO.task(this.task, this.taskIndex) : allTasksPage = false;
}
