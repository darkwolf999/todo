import 'package:todo/domain/models/task_model.dart';

abstract class TasksRepository {

  Stream<List<TaskModel>> getTasks();

  Future<void> fetchTasks();

  Future<void> saveTask(TaskModel task);

  Future<void> deleteTask(String uuid);

  Future<void> fetchSingleTaskFromNetwork(String uuid);

  Future<void> fetchSingleTaskFromDB(String uuid);

  Future<void> refreshNetworkTasks(List<TaskModel> tasks);

}
