import 'package:todo/data/api/tasks_api.dart';
import 'package:todo/data/models/task_model.dart';

class TasksRepository {
  const TasksRepository({
    required TasksApi tasksApi,
  }) : _tasksApi = tasksApi;

  final TasksApi _tasksApi;

  Stream<List<TaskModel>> getTasks() => _tasksApi.getTasks();

  Future<void> saveTask(TaskModel task) => _tasksApi.saveTask(task);

  Future<void> deleteTask(String uuid) => _tasksApi.deleteTask(uuid);
}
