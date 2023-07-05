import 'package:todo/data/models/db/task_db.dart';

abstract class DatabaseTasksApi {

  Future<List<DBTask>?> fetchTasks();

  Future<DBTask?> fetchSingleTask(String uuid);

  Future<void> putTask(DBTask task);

  Future<void> refreshTasks(List<DBTask> tasks, List<int> isarIds);

  Future<void> putAllTasks(List<DBTask> tasks);

  Future<void> deleteTask(String uuid);

}
