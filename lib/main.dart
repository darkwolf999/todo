import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/data/api/database_tasks_api.dart';
import 'package:todo/data/interceptors/dio_interceptor.dart';
import 'package:todo/l10n/codegen_loader.g.dart';
import 'package:todo/my_logger.dart';
import 'package:todo/presentation/screens/all_tasks/all_tasks.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:todo/data/repositories/tasks_repository.dart';
import 'data/api/network_tasks_api.dart';
import 'data/db/task_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  final tasksRepository = await initRepo();

  MyLogger.infoLog('Starting application!');

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      path: 'lib/assets/translations',
      fallbackLocale: Locale('ru'),
      assetLoader: CodegenLoader(),
      child: RepositoryProvider<TasksRepository>(
        lazy: false,
        create: (context) => tasksRepository,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: const [Locale('en'), Locale('ru')],
      locale: context.locale,
      home: const AllTasksScreen(),
    );
  }
}

Future<TasksRepository> initRepo() async {
  BaseOptions options = BaseOptions(
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
  );

  Dio dio = Dio(options);
  dio.interceptors.addAll([
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
    ),
    DioInterceptor(),
  ]);

  SharedPreferences prefs = await SharedPreferences.getInstance();

  final networkTasksApi = NetworkTasksApi(
    dio: dio,
    prefs: prefs,
  );

  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [DBTaskSchema],
    directory: dir.path,
  );

  final databaseTasksApi = DatabaseTasksApi(
    isar: isar,
  );

  final tasksRepository = TasksRepository(
    prefs: prefs,
    networkTasksApi: networkTasksApi,
    databaseTasksApi: databaseTasksApi,
  );

  return tasksRepository;
}
