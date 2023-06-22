import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/data/api/database_tasks_api.dart';
import 'package:todo/data/mappers/db_task_mapper.dart';

import 'package:todo/data/mappers/dto_task_mapper.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/data/api/network_tasks_api.dart';
import 'package:todo/data/dto/task_dto.dart';

class TasksRepository {
  TasksRepository({
    required SharedPreferences prefs,
    required NetworkTasksApi networkTasksApi,
    required DatabaseTasksApi databaseTasksApi,
  })  : _prefs = prefs,
        _networkTasksApi = networkTasksApi,
        _databaseTasksApi = databaseTasksApi;

  final SharedPreferences _prefs;
  final NetworkTasksApi _networkTasksApi;
  final DatabaseTasksApi _databaseTasksApi;

  final _tasksStreamController =
      BehaviorSubject<List<TaskModel>>.seeded(const []);

  Stream<List<TaskModel>> getTasks() => _tasksStreamController;

  Future<void> fetchTasks() async {
    final tasksListDB = await _databaseTasksApi.fetchTasks();
    final tasks = <TaskModel>[];
    for (final dto in tasksListDB!) {
      tasks.add(dto.toDomain());
    }
    //final tasksListDto = await _networkTasksApi.fetchTasks();
    // final tasks = <TaskModel>[];
    // for (final dto in tasksListDto.list) {
    //   tasks.add(dto.toDomain());
    // }
    // final reversedTasks = tasks.reversed;
    // _tasksStreamController.add(reversedTasks.toList());
    _tasksStreamController.add(tasks);
  }

  Future<void> saveTask(TaskModel task) async {
    final taskDto = task.toDto();

    final tasks = [..._tasksStreamController.value];
    final taskIndex = tasks.indexWhere((t) => t.uuid == task.uuid);
    if (taskIndex >= 0) {
      tasks[taskIndex] = task;
      _tasksStreamController.add(tasks);
      final taskDB = task.toDB();
      _databaseTasksApi.addNewTask(taskDB);

      //final taskResponseDto = await _networkTasksApi.editTask(taskDto);
    } else {
      tasks.insert(0, task);
      _tasksStreamController.add(tasks);
      final taskDB = task.toDB();
      _databaseTasksApi.addNewTask(taskDB);

      //final taskResponseDto = await _networkTasksApi.addNewTask(taskDto);
    }
  }

  Future<void> deleteTask(String uuid) async {
    final tasks = [..._tasksStreamController.value];
    final taskIndex = tasks.indexWhere((t) => t.uuid == uuid);
    if (taskIndex == -1) {
      throw Exception();
    } else {
      tasks.removeAt(taskIndex);

      _tasksStreamController.add(tasks);

      await _databaseTasksApi.deleteTask(uuid);
      //final taskResponseDto = await _networkTasksApi.deleteTask(uuid);
    }
  }

  Future<void> fetchSingleTask(String uuid) async {
    final taskResponseDto = await _networkTasksApi.fetchSingleTask(uuid);
  }

  Future<void> refreshTasks(List<TaskModel> tasks) async {
    final tasksDto = <TaskDto>[];
    for (final task in tasks) {
      tasksDto.add(task.toDto());
    }

    final tasksListDto = await _networkTasksApi.refreshTasks(tasksDto);
  }
}
