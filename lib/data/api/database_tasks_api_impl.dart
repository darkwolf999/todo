import 'package:isar/isar.dart';

import 'package:todo/data/api/database_tasks_api.dart';
import 'package:todo/helpers/fast_hash.dart';
import 'package:todo/data/models/db/task_db.dart';

class DatabaseTasksApiImpl implements DatabaseTasksApi {
  final Isar _isar;

  DatabaseTasksApiImpl({
    required Isar isar,
  }) : _isar = isar;

  @override
  Future<List<DBTask>?> fetchTasks() async {
    List<DBTask>? tasksDB;

    await _isar.txn(() async {
      tasksDB = await _isar.dBTasks.where().findAll();
    });

    return tasksDB;
  }

  @override
  Future<DBTask?> fetchSingleTask(String uuid) async {
    int isarId = FastHash.generate(uuid);
    final taskDB = await _isar.dBTasks.get(isarId);
    return taskDB;
  }

  @override
  Future<void> putTask(DBTask task) async {
    await _isar.writeTxn(
      () async {
        await _isar.dBTasks.put(task);
      },
    );
  }

  @override
  Future<void> refreshTasks(List<DBTask> tasks, List<int> isarIds) async {
    await _isar.writeTxn(
      () async {
        await _isar.dBTasks.putAll(tasks);
        await _isar.dBTasks.deleteAll(isarIds);
      },
    );
  }

  @override
  Future<void> putAllTasks(List<DBTask> tasks) async {
    await _isar.writeTxn(
      () async {
        await _isar.dBTasks.putAll(tasks);
      },
    );
  }

  @override
  Future<void> deleteTask(String uuid) async {
    int isarId = FastHash.generate(uuid);
    await _isar.writeTxn(() async {
      await _isar.dBTasks.delete(isarId);
    });
  }
}
