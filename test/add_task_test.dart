import 'package:flutter_test/flutter_test.dart';
import 'package:todo/data/repositories/tasks_repository_impl.dart';
import 'package:todo/domain/models/task_model.dart';
import 'package:todo/domain/repository/tasks_repository.dart';
import 'package:uuid/uuid.dart';
import 'package:mockito/mockito.dart';
import 'mocks/data/data_layer.mocks.dart';

void main() {
  final TasksRepository repository = MockTasksRepository();
  //final CreateTaskUseCase usecase = CreateTodoUseCaseImpl(repository);
  final date = DateTime.now().millisecondsSinceEpoch;
  final uuid = const Uuid().v4();
  final task = TaskModel(
    uuid: uuid,
    title: 'test$uuid',
    isDone: false,
    deadline: null,
    createdAt: date,
    lastUpdatedBy: 'id$uuid',
    changedAt: date,
    priority: Priority.no,
  );
  final expected = task;

  setUp(() {
    when(repository.saveTask(task))
        .thenAnswer((_) async => task);
  });

}