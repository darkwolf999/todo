import 'package:todo/data/models/task_model.dart';

abstract class TasksApi {
  const TasksApi();

  Stream<List<TaskModel>> getTasks();

  Future<void> saveTask(TaskModel task);

  Future<void> deleteTask(String uuid);
}
