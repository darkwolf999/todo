import 'package:flutter_test/flutter_test.dart';
import 'package:todo/data/api/database_tasks_api.dart';
import 'package:todo/data/api/network_tasks_api.dart';
import 'package:todo/data/api/revision_provider.dart';
import 'package:todo/data/models/db/task_db.dart';
import 'package:todo/data/models/dto/task_dto.dart';
import 'package:todo/data/models/dto/tasks_list_dto.dart';
import 'package:todo/data/repositories/tasks_repository_impl.dart';
import 'package:todo/domain/models/task_model.dart' as model;
import 'package:todo/domain/repository/tasks_repository.dart';
import 'package:todo/helpers/network_checker/network_checker.dart';
import 'package:uuid/uuid.dart';
import 'package:mockito/mockito.dart';
import '../mocks/data/data_layer.mocks.dart';

void main() async {
  NetworkTasksApi networkTasksApi = MockNetworkTasksApi();
  DatabaseTasksApi databaseTasksApi = MockDatabaseTasksApi();
  RevisionProvider revisionProvider = MockRevisionProvider();
  NetworkChecker networkChecker = MockNetworkChecker();

  final TasksRepository repository = TasksRepositoryImpl(
    networkChecker: networkChecker,
    revisionProvider: revisionProvider,
    networkTasksApi: networkTasksApi,
    databaseTasksApi: databaseTasksApi,
  );

  final date = DateTime
      .now()
      .millisecondsSinceEpoch;
  final uuid = const Uuid().v4();

  List<model.TaskModel> expected = [
    model.TaskModel(
      uuid: uuid,
      title: 'test$uuid',
      isDone: false,
      deadline: null,
      createdAt: date,
      lastUpdatedBy: 'id$uuid',
      changedAt: date,
      priority: model.Priority.no,
    )
  ];

  final dbTask = DBTask(
    uuid: uuid,
    title: 'test$uuid',
    isDone: false,
    deadline: null,
    createdAt: date,
    lastUpdatedBy: 'id$uuid',
    changedAt: date,
    priority: Priority.no,
  );

  final dtoTasks = [TaskDto(
    id: uuid,
    text: 'test$uuid',
    importance: Importance.basic,
    done: false,
    createdAt: 0,
    changedAt: 0,
    lastUpdatedBy: 'lastUpdatedBy',
  )];
  final TasksListDto tasksListDto = TasksListDto(
      status: 'ok',
      list: dtoTasks,
      revision: 1
  );

  setUp(() {
    when(networkChecker.hasInternet()).thenAnswer((_) async => true);
    when(revisionProvider.getRevision()).thenAnswer((_) => 1);
    when(networkTasksApi.fetchTasks()).thenAnswer((_) async  => tasksListDto);
    when(databaseTasksApi.fetchTasks()).thenAnswer((_) async => [dbTask]);
  });

  test('should return tasks from db to viewStream in online mode', () async {
    await repository.fetchTasks();
    final stream = repository.getTasks();
    final actual = await stream.first;

    expect(expected, actual);
  });
}
