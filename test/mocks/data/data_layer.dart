import 'package:mockito/annotations.dart';
import 'package:todo/data/api/database_tasks_api.dart';
import 'package:todo/data/api/network_tasks_api.dart';
import 'package:todo/domain/repository/tasks_repository.dart';

import 'data_layer.mocks.dart';

@GenerateMocks([TasksRepository, NetworkTasksApi, DatabaseTasksApi])
void main() {}