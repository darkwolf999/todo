import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/my_logger.dart';
import 'package:todo/presentation/screens/all_tasks/all_tasks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo/repositories/tasks_repository.dart';
import 'data/api/local_tasks_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final tasksApi = LocalTasksApi(
    prefs: await SharedPreferences.getInstance(),
  );
  final tasksRepository = TasksRepository(tasksApi: tasksApi);

  runApp(
    RepositoryProvider<TasksRepository>(
      lazy: false,
      create: (context) => tasksRepository,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MyLogger.infoLog('Application started');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [Locale('en'), Locale('ru')],
      home: const AllTasksScreen(),
    );
  }
}
