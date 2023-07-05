import 'package:mockito/annotations.dart';
import 'package:todo/data/api/database_tasks_api.dart';
import 'package:todo/data/api/network_tasks_api.dart';
import 'package:todo/data/api/revision_provider.dart';
import 'package:todo/domain/repository/tasks_repository.dart';
import 'package:todo/helpers/network_checker/network_checker.dart';

import 'data_layer.mocks.dart';

@GenerateMocks([
  NetworkTasksApi,
  DatabaseTasksApi,
  RevisionProvider,
  NetworkChecker,
])
void main() {}
