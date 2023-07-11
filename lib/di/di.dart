import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/data/api/revision_provider.dart';
import 'package:todo/data/api/revision_provider_impl.dart';

import 'package:todo/helpers/device_info.dart';
import 'package:todo/data/api/database_tasks_api.dart';
import 'package:todo/data/api/database_tasks_api_impl.dart';
import 'package:todo/data/models/db/task_db.dart';
import 'package:todo/helpers/network_checker/network_checker.dart';
import 'package:todo/helpers/network_checker/network_checker_impl.dart';
import 'package:todo/navigation/tasks_router_delegate.dart';

class DepInj {
  DepInj._();

  static Future<void> inject() async {
    GetIt.I.registerSingleton<RouterDelegate<Object>>(TasksRouterDelegate());

    final deviceModel = await DeviceInfo.getDeviceModel();
    GetIt.I.registerSingleton(deviceModel, instanceName: 'deviceModel');

    Dio dio = Dio();
    GetIt.I.registerSingleton(dio);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    GetIt.I.registerSingleton(prefs);

    NetworkChecker networkChecker = NetworkCheckerImpl();
    GetIt.I.registerSingleton(networkChecker);

    GetIt.I.registerSingleton<RevisionProvider>(
      RevisionProviderImpl(
        prefs: GetIt.I.get(),
      ),
    );

    final dir = await getApplicationDocumentsDirectory();

    final isar = await Isar.open(
      [DBTaskSchema],
      directory: dir.path,
    );
    GetIt.I.registerSingleton(isar);

    GetIt.I.registerSingleton<DatabaseTasksApi>(
      DatabaseTasksApiImpl(
        isar: GetIt.I.get(),
      ),
    );
  }
}
