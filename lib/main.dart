import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo/todo_app.dart';

import 'di/di.dart';
import 'package:todo/data/repositories/tasks_repository_impl.dart';
import 'package:todo/l10n/codegen_loader.g.dart';
import 'package:todo/my_logger.dart';
import 'data/api/network_tasks_api_impl.dart';
import 'domain/bloc/error_bloc/error_bloc.dart';
import 'domain/bloc/error_bloc/error_event.dart';
import 'domain/bloc/firebase/remote_config/remote_config_bloc.dart';
import 'domain/repository/tasks_repository.dart';
import 'config/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await dotenv.load(fileName: '.env');

  await firebaseInit();

  await DepInj.inject();

  MyLogger.infoLog('Starting application!');

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      path: 'lib/assets/translations',
      fallbackLocale: Locale('ru'),
      assetLoader: CodegenLoader(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => RemoteConfigBloc(GetIt.I.get())
              ..add(
                const InitConfigEvent(),
              ),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => ErrorBloc(),
            lazy: false,
          ),
        ],
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
          child: const ToDoApp(),
        ),
      ),
    ),
  );
}

Future<void> firebaseInit() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}