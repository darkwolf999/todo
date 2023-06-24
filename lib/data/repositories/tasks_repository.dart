import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:todo/data/api/database_tasks_api.dart';
import 'package:todo/data/mappers/db_dto_task_mapper.dart';
import 'package:todo/data/mappers/domain_db_task_mapper.dart';
import 'package:todo/data/mappers/domain_dto_task_mapper.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/data/api/network_tasks_api.dart';
import 'package:todo/data/dto/task_dto.dart';
import 'package:todo/my_logger.dart';
import 'package:todo/data/db/task_db.dart';

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
    int? localRevision = _prefs.getInt('revision');
    MyLogger.infoLog('Local revision - $localRevision');

    final dtoTasks = await _networkTasksApi.fetchTasks();
    final dBTasks = await _databaseTasksApi.fetchTasks();

    int? networkRevision = _prefs.getInt('revision');
    MyLogger.infoLog('Network revision - $networkRevision');

    final dBTasksFromDto = <DBTask>[];

    if (localRevision != networkRevision) {
      for (final dto in dtoTasks.list) {
        dBTasksFromDto.add(dto.toDB());
      }

      //Если таски нет на сервере, но есть в локальной бд,
      //то ее надо удалить из локальной бд
      List<int> dBTasksToDeleteIds = [];

      dBTasks?.forEach((element) {
        if (dtoTasks.list.where((t) => t.id == element.uuid).isEmpty) {
          dBTasksToDeleteIds.add(element.isarId);
        }
      });

      await _databaseTasksApi.refreshTasks(dBTasksFromDto, dBTasksToDeleteIds);
    }

    final tasksToView = <TaskModel>[];

    final tasksDBtoModel = await _databaseTasksApi.fetchTasks();
    for (final taskDB in tasksDBtoModel!) {
      tasksToView.add(taskDB.toDomain());
    }

    //Задачи на экране всегда отсортированы по времени создания.
    //Самая верхняя - самая новая
    tasksToView.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    _tasksStreamController.add(tasksToView);
  }

  Future<void> saveTask(TaskModel task) async {
    final taskDto = task.toDto();
    final taskDB = task.toDB();
    final tasks = [..._tasksStreamController.value];
    final taskIndex = tasks.indexWhere((t) => t.uuid == task.uuid);
    if (taskIndex >= 0) {
      tasks[taskIndex] = task;
      _tasksStreamController.add(tasks);
      _networkTasksApi.editTask(taskDto);
    } else {
      tasks.insert(0, task);
      _tasksStreamController.add(tasks);
      _networkTasksApi.addNewTask(taskDto);
    }
    _databaseTasksApi.putTask(taskDB);
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
      await _networkTasksApi.deleteTask(uuid);
    }
  }

  Future<void> fetchSingleTaskFromNetwork(String uuid) async {
    final taskResponseDto = await _networkTasksApi.fetchSingleTask(uuid);
  }

  Future<void> fetchSingleTaskFromDB(String uuid) async {
    final taskResponseDto = await _databaseTasksApi.fetchSingleTask(uuid);
  }

  Future<void> refreshNetworkTasks(List<TaskModel> tasks) async {
    final tasksDto = <TaskDto>[];
    for (final task in tasks) {
      tasksDto.add(task.toDto());
    }
    final tasksListDto = await _networkTasksApi.refreshTasks(tasksDto);
  }
}
