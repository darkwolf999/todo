import 'package:rxdart/rxdart.dart';
import 'package:todo/data/api/revision_provider.dart';

import 'package:todo/data/mappers/db_dto_task_mapper.dart';
import 'package:todo/data/mappers/domain_db_task_mapper.dart';
import 'package:todo/data/mappers/domain_dto_task_mapper.dart';
import 'package:todo/data/models/dto/task_response_dto.dart';
import 'package:todo/domain/models/task_model.dart';
import 'package:todo/data/models/dto/task_dto.dart';
import 'package:todo/domain/repository/tasks_repository.dart';
import 'package:todo/helpers/network_checker/network_checker.dart';
import 'package:todo/my_logger.dart';
import 'package:todo/data/models/db/task_db.dart';
import 'package:todo/constants.dart' as Constants;
import 'package:todo/data/api/database_tasks_api.dart';
import 'package:todo/data/api/network_tasks_api.dart';

class TasksRepositoryImpl implements TasksRepository{
  TasksRepositoryImpl({
    required NetworkChecker networkChecker,
    required RevisionProvider revisionProvider,
    required NetworkTasksApi networkTasksApi,
    required DatabaseTasksApi databaseTasksApi,
  })  : _networkChecker = networkChecker,
        _revisionProvider = revisionProvider,
        _networkTasksApi = networkTasksApi,
        _databaseTasksApi = databaseTasksApi;

  final NetworkChecker _networkChecker;
  final RevisionProvider _revisionProvider;
  final NetworkTasksApi _networkTasksApi;
  final DatabaseTasksApi _databaseTasksApi;

  final _tasksStreamController =
      BehaviorSubject<List<TaskModel>>.seeded(const []);

  @override
  Stream<List<TaskModel>> getTasks() => _tasksStreamController;

  @override
  Future<void> fetchTasks() async {
    //bool hasInternet = await NetworkChecker.hasInternet();
    bool hasInternet = await _networkChecker.hasInternet();
    //int? localRevision = _prefs.getInt('revision') ?? Constants.defaultRevision; //todo подумать как тут быть
    int localRevision = _revisionProvider.getRevision();
    MyLogger.infoLog('Local revision - $localRevision');

    if(hasInternet) {

      final dtoTasks = await _networkTasksApi.fetchTasks();
      final dBTasks = await _databaseTasksApi.fetchTasks();

      final dBTasksFromDto = <DBTask>[];

      if (localRevision < dtoTasks.revision) {

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

        // await _prefs.setInt(
        //   Constants.shPrefsRevisionKey,
        //   dtoTasks.revision,
        // );
        await _revisionProvider.updateRevision(dtoTasks.revision);

      } else if(localRevision > dtoTasks.revision) {
        final tasksDBtoDTO = await _databaseTasksApi.fetchTasks();
        final taskstoDTO = <TaskDto>[];

        for (final taskDB in tasksDBtoDTO!) {
          taskstoDTO.add(taskDB.toDto());
        }

        final tasksResponse = await _networkTasksApi.refreshTasks(taskstoDTO);

        // await _prefs.setInt(
        //   Constants.shPrefsRevisionKey,
        //   tasksResponse.revision,
        // );
        await _revisionProvider.updateRevision(tasksResponse.revision);
      }

    } else {
      MyLogger.infoLog('offline mode');
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

  @override
  Future<void> saveTask(TaskModel task) async {
    //int? localRevision = _prefs.getInt('revision');
    //int? localRevision = _prefs.getInt('revision') ?? Constants.defaultRevision;
    int localRevision = _revisionProvider.getRevision();
    final taskDto = task.toDto();
    final taskDB = task.toDB();
    final tasks = [..._tasksStreamController.value];
    final taskIndex = tasks.indexWhere((t) => t.uuid == task.uuid);
    //Кладу таски в стрим в первую очередь
    //чтобы они сразу появились на экране без задержек
    if (taskIndex >= 0) {
      tasks[taskIndex] = task;
      _tasksStreamController.add(tasks);
    }
    else {
      tasks.insert(0, task);
      _tasksStreamController.add(tasks);
    }

    //bool hasInternet = await NetworkChecker.hasInternet();
    bool hasInternet = await _networkChecker.hasInternet();

    if(hasInternet) {
      final TaskResponseDto taskResponseDto;
      if (taskIndex >= 0) {
        taskResponseDto = await _networkTasksApi.editTask(taskDto);
      } else {
        taskResponseDto = await _networkTasksApi.addNewTask(taskDto);
      }
      // await _prefs.setInt(
      //   Constants.shPrefsRevisionKey,
      //   taskResponseDto.revision,
      // );
      await _revisionProvider.updateRevision(taskResponseDto.revision);
    } else {
      // await _prefs.setInt(
      //   Constants.shPrefsRevisionKey,
      //   ++localRevision,
      //   //localRevision = localRevision != null ? localRevision + 1 : 1,
      // );
      await _revisionProvider.updateRevision(++localRevision);
    }
    await _databaseTasksApi.putTask(taskDB);
  }

  @override
  Future<void> deleteTask(String uuid) async {
    //int? localRevision = _prefs.getInt('revision');
    //int? localRevision = _prefs.getInt('revision') ?? Constants.defaultRevision;
    int localRevision = _revisionProvider.getRevision();
    final tasks = [..._tasksStreamController.value];
    final taskIndex = tasks.indexWhere((t) => t.uuid == uuid);
    if (taskIndex == -1) {
      throw Exception();
    } else {
      tasks.removeAt(taskIndex);
      _tasksStreamController.add(tasks);
    }

    //bool hasInternet = await NetworkChecker.hasInternet();
    bool hasInternet = await _networkChecker.hasInternet();

    if(hasInternet) {
      final TaskResponseDto taskResponseDto;
      taskResponseDto = await _networkTasksApi.deleteTask(uuid);
      // await _prefs.setInt(
      //   Constants.shPrefsRevisionKey,
      //   taskResponseDto.revision,
      // );
      await _revisionProvider.updateRevision(taskResponseDto.revision);
    } else {
      // await _prefs.setInt(
      //   Constants.shPrefsRevisionKey,
      //   ++localRevision,
      //   //localRevision = localRevision != null ? localRevision + 1 : 1,
      // );
      await _revisionProvider.updateRevision(++localRevision);
    }
    await _databaseTasksApi.deleteTask(uuid);
  }

  @override
  Future<void> fetchSingleTaskFromNetwork(String uuid) async {
    final taskResponseDto = await _networkTasksApi.fetchSingleTask(uuid);
  }

  @override
  Future<void> fetchSingleTaskFromDB(String uuid) async {
    final taskResponseDto = await _databaseTasksApi.fetchSingleTask(uuid);
  }

  // @override
  // Future<void> refreshNetworkTasks(List<TaskModel> tasks) async {
  //   final tasksDto = <TaskDto>[];
  //   for (final task in tasks) {
  //     tasksDto.add(task.toDto());
  //   }
  //   final tasksListDto = await _networkTasksApi.refreshTasks(tasksDto);
  // }
}
