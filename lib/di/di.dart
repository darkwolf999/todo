import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/helpers/device_info.dart';

import '../data/api/database_tasks_api.dart';
import '../data/api/network_tasks_api.dart';
import '../data/interceptors/dio_interceptor.dart';
import '../data/models/db/task_db.dart';
import '../data/repositories/tasks_repository_impl.dart';
import '../domain/repository/tasks_repository.dart';

class DepInj {
  DepInj._();

  static Future<void> inject() async {
    final deviceModel = await DeviceInfo.getDeviceModel();
    GetIt.I.registerSingleton(deviceModel, instanceName: 'deviceModel');

    Dio dio = Dio();
    // dio.interceptors.addAll([
    //   PrettyDioLogger(
    //     requestHeader: true,
    //     requestBody: true,
    //   ),
    //   DioInterceptor(onErrorHandler),
    // ]);
    GetIt.I.registerSingleton(dio);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    GetIt.I.registerSingleton(prefs);

    // final networkTasksApi = NetworkTasksApi(
    //   dio: GetIt.I.get(),
    //   prefs: GetIt.I.get(),
    // );
    // GetIt.I.registerSingleton(networkTasksApi);

    final dir = await getApplicationDocumentsDirectory();

    final isar = await Isar.open(
      [DBTaskSchema],
      directory: dir.path,
    );
    GetIt.I.registerSingleton(isar);

    final databaseTasksApi = DatabaseTasksApi(
      isar: GetIt.I.get(),
    );
    GetIt.I.registerSingleton(databaseTasksApi);

    // GetIt.I.registerSingleton<TasksRepository>(
    //   TasksRepositoryImpl(
    //     prefs: GetIt.I.get(),
    //     networkTasksApi: GetIt.I.get(),
    //     databaseTasksApi: GetIt.I.get(),
    //   ),
    // );
  }
}
