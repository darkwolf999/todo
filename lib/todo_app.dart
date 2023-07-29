import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/navigation/tasks_router_delegate.dart';
import 'package:todo/themes/app_theme.dart';

import 'navigation/parser.dart';

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: GetIt.I.get<TasksRouterDelegate>(),
      routeInformationParser: TasksRouteInformationParser(),
      debugShowCheckedModeBanner: false,
      title: 'To-Do!',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: const [Locale('en'), Locale('ru')],
      locale: context.locale,
    );
  }
}
