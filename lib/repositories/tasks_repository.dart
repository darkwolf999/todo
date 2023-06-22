import 'package:rxdart/rxdart.dart';

import 'package:todo/data/mappers/task_mapper.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/data/api/network_tasks_api.dart';
import 'package:todo/data/dto/task_dto.dart';

class TasksRepository {
  TasksRepository({
    required NetworkTasksApi networkTasksApi,
  }) : _networkTasksApi = networkTasksApi;

  final NetworkTasksApi _networkTasksApi;

  final _tasksStreamController =
      BehaviorSubject<List<TaskModel>>.seeded(const []);

  Stream<List<TaskModel>> getTasks() => _tasksStreamController;

  Future<void> fetchTasks() async {
    final tasksListDto = await _networkTasksApi.fetchTasks();
    final tasks = <TaskModel>[];
    for (final dto in tasksListDto.list) {
      tasks.add(dto.toDomain());
    }
    final reversedTasks = tasks.reversed;
    _tasksStreamController.add(reversedTasks.toList());
  }

  Future<void> saveTask(TaskModel task) async {
    final taskDto = task.toDto();

    final tasks = [..._tasksStreamController.value];
    final taskIndex = tasks.indexWhere((t) => t.uuid == task.uuid);
    if (taskIndex >= 0) {
      tasks[taskIndex] = task;
      _tasksStreamController.add(tasks);
      final taskResponseDto = await _networkTasksApi.editTask(taskDto);
    } else {
      tasks.insert(0, task);
      _tasksStreamController.add(tasks);
      final taskResponseDto = await _networkTasksApi.addNewTask(taskDto);
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

      final taskResponseDto = await _networkTasksApi.deleteTask(uuid);
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
