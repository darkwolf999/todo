import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:easy_localization/easy_localization.dart';

import 'di/di.dart';
import 'package:todo/data/repositories/tasks_repository_impl.dart';
import 'package:todo/l10n/codegen_loader.g.dart';
import 'package:todo/my_logger.dart';
import 'data/api/network_tasks_api_impl.dart';
import 'domain/bloc/error_bloc/error_bloc.dart';
import 'domain/bloc/error_bloc/error_event.dart';
import 'domain/repository/tasks_repository.dart';
import 'navigation/parser.dart';
import 'navigation/tasks_router_delegate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await dotenv.load(fileName: 'url_token.env');
  //await dotenv.load(fileName: 'template.env');

  await DepInj.inject();

  MyLogger.infoLog('Starting application!');

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      path: 'lib/assets/translations',
      fallbackLocale: Locale('ru'),
      assetLoader: CodegenLoader(),
      child: BlocProvider(
        create: (_) => ErrorBloc(),
        lazy: false,
        child: RepositoryProvider<TasksRepository>(
          lazy: false,
          create: (BuildContext context) => TasksRepositoryImpl(
            networkChecker: GetIt.I.get(),
            revisionProvider: GetIt.I.get(),
            databaseTasksApi: GetIt.I.get(),
            networkTasksApi: NetworkTasksApiImpl(
              dio: GetIt.I.get(),
              prefs: GetIt.I.get(),
              onErrorHandler: (String code, String message) {
                context.read<ErrorBloc>().add(
                      OnErrorEvent(
                        statusCode: code,
                        message: message,
                      ),
                    );
              },
            ),
          ),
          child: const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final routeObserver = RouteObserver();
    return Provider<RouteObserver>.value(
      value: routeObserver,
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            routerDelegate: TasksRouterDelegate(),
            routeInformationParser: TasksRouteInformationParser(),
            debugShowCheckedModeBanner: false,
            title: 'To-Do!',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: const [Locale('en'), Locale('ru')],
            locale: context.locale,
            //home: const Navigation(),
            //home: const AllTasksScreen(),
          );
        },
      ),
    );
  }
}
