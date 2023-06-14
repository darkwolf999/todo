import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/data/models/taskModel.dart';
import 'package:rxdart/subjects.dart';

import 'tasks_api.dart';

class LocalTasksApi extends TasksApi {
  LocalTasksApi({
    required SharedPreferences prefs,
  }) : _sharedPrefs = prefs {
    _init();
  }

  final SharedPreferences _sharedPrefs;

  final _tasksStreamController =
      BehaviorSubject<List<TaskModel>>.seeded(const []);

  void _init() {
    final tasksJson = _sharedPrefs.getString("allTasks");
    if (tasksJson != null) {
      final tasks = List<Map<dynamic, dynamic>>.from(
        json.decode(tasksJson) as List,
      )
          .map((jsonMap) =>
              TaskModel.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _tasksStreamController.add(tasks);
    } else {
      _tasksStreamController.add(const []);
    }
  }

  @override
  Stream<List<TaskModel>> getTasks() => _tasksStreamController;

  @override
  Future<void> saveTask(TaskModel task) {
    final tasks = [..._tasksStreamController.value];
    final taskIndex = tasks.indexWhere((t) => t.uuid == task.uuid);
    if (taskIndex >= 0) {
      tasks[taskIndex] = task;
    } else {
      tasks.insert(0, task);
    }

    _tasksStreamController.add(tasks);

    return _sharedPrefs.setString("allTasks", json.encode(tasks));
  }

  Future<void> _setValue(String key, String value) =>
      _sharedPrefs.setString(key, value);

  @override
  Future<void> deleteTask(String uuid) async {
    final tasks = [..._tasksStreamController.value];
    final taskIndex = tasks.indexWhere((t) => t.uuid == uuid);
    if (taskIndex == -1) {
      throw Exception();
    } else {
      tasks.removeAt(taskIndex);
      _tasksStreamController.add(tasks);
      return _setValue("allTasks", json.encode(tasks));

      //return _sharedPrefs.setString("allTasks", json.encode(tasks)) as Future<void>;
    }
  }
}
