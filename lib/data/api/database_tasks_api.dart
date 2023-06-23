import 'dart:io';
import 'package:isar/isar.dart';

import 'package:todo/helpers/fast_hash.dart';
import 'package:todo/data/db/task_db.dart';

class DatabaseTasksApi {
  final Directory _dir;
  final Isar _isar;

  DatabaseTasksApi({
    required Directory dir,
    required Isar isar,
  })  : _dir = dir,
        _isar = isar;

  Future<List<TaskDB>?> fetchTasks() async {
    List<TaskDB>? tasksDB;

    await _isar.txn(() async {
      tasksDB = await _isar.taskDBs.where().findAll();
    });

    return tasksDB;
  }

  Future<TaskDB?> fetchSingleTask(String uuid) async {
    int isarId = FastHash.generate(uuid);
    final taskDB = await _isar.taskDBs.get(isarId);
    return taskDB;
  }

  Future<void> putTask(TaskDB task) async {
    await _isar.writeTxn(
      () async {
        await _isar.taskDBs.put(task);
      },
    );
  }

  Future<void> refreshTasks(List<TaskDB> tasks) async {
    await _isar.writeTxn(
      () async {
        await _isar.taskDBs.putAll(tasks);
      },
    );
  }

  Future<void> deleteTask(String uuid) async {
    int isarId = FastHash.generate(uuid);
    await _isar.writeTxn(() async {
      await _isar.taskDBs.delete(isarId);
    });
  }
}