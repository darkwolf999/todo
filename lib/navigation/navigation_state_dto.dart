import 'package:todo/domain/models/task_model.dart';

class NavigationStateDTO {
  bool allTasksPage;
  TaskModel? task;

  NavigationStateDTO(this.allTasksPage, this.task);

  NavigationStateDTO.allTasksPage()
      : allTasksPage = true,
        task = null;

  NavigationStateDTO.task(this.task) : allTasksPage = false;
}
