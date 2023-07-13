import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/data/api/analytics_provider.dart';
import 'package:todo/data/api/constants/api_constants.dart';

import 'package:todo/domain/models/task_model.dart';
import 'package:todo/presentation/models/tasks_filter.dart';
import 'package:todo/my_logger.dart';
import 'package:todo/domain/repository/tasks_repository.dart';

part 'all_tasks_screen_event.dart';

part 'all_tasks_screen_state.dart';

class AllTasksScreenBloc
    extends Bloc<AllTasksScreenEvent, AllTasksScreenState> {
  final TasksRepository _tasksRepository;
  final AnalyticsProvider _analyticsProvider;
  bool isCompletedTasksShown = false;

  AllTasksScreenBloc(
    this._tasksRepository,
    this._analyticsProvider,
  ) : super(const AllTasksScreenState()) {
    on<SubscribeStreamEvent>(_onSubscribeStream);
    //on<AddTaskEvent>(_onAddTask);
    on<DeleteTaskEvent>(_onDeleteTask, transformer: sequential());
    on<CompleteTaskEvent>(_onCompleteTask, transformer: sequential());
    on<ChangeFilterEvent>(_onChangeFilter);
  }

  Future<void> _onSubscribeStream(
    SubscribeStreamEvent event,
    Emitter<AllTasksScreenState> emit,
  ) async {
    emit(state.copyWith(status: AllTasksScreenStatus.initial));

    try {
      await _tasksRepository.fetchTasks();
      await emit.forEach<List<TaskModel>>(
        _tasksRepository.getTasks(),
        onData: (tasks) => state.copyWith(
          status: AllTasksScreenStatus.success,
          tasks: tasks,
          completedTasksCount: tasks.isNotEmpty
              ? tasks
                  .map((element) => element.isDone ? 1 : 0)
                  .reduce((value, element) => value + element)
              : 0,
        ),
      );
    } catch (e) {
      MyLogger.errorLog('tasks fetch error', e);
      emit(state.copyWith(status: AllTasksScreenStatus.failure));
    }
  }

  // Future<void> _onAddTask(
  //   AddTaskEvent event,
  //   Emitter<AllTasksScreenState> emit,
  // ) async {
  //   emit(state.copyWith(status: AllTasksScreenStatus.initial));
  //   try {
  //     await _tasksRepository.saveTask(event.task);
  //     emit(state.copyWith(status: AllTasksScreenStatus.success));
  //     MyLogger.infoLog('task added');
  //   } catch (e) {
  //     MyLogger.errorLog('task add error', e);
  //     emit(state.copyWith(status: AllTasksScreenStatus.failure));
  //   }
  // }

  Future<void> _onDeleteTask(
    DeleteTaskEvent event,
    Emitter<AllTasksScreenState> emit,
  ) async {
    try {
      await _tasksRepository.deleteTask(event.uuid);
      MyLogger.infoLog('tasks after deleting ${state.tasks}');
      _analyticsProvider.logEvent(
        ApiConstants.taskDeleted,
        {'task_uuid': event.uuid},
      );
    } catch (e) {
      MyLogger.errorLog('task delete error', e);
      emit(state.copyWith(status: AllTasksScreenStatus.failure));
    }
  }

  Future<void> _onCompleteTask(
    CompleteTaskEvent event,
    Emitter<AllTasksScreenState> emit,
  ) async {
    final completedTask = event.task.copyWith(isDone: !event.task.isDone);
    await _tasksRepository.saveTask(completedTask);
    MyLogger.infoLog('task after completion: ${state.tasks}');
    MyLogger.infoLog('completed count: ${state.completedTasksCount}');
    completedTask.isDone == true
        ? _analyticsProvider.logEvent(
            ApiConstants.taskCompleted,
            {
              'task_uuid': event.task.uuid,
              'task_title': event.task.title,
            },
          )
        : _analyticsProvider.logEvent(
            ApiConstants.taskUncompleted,
            {
              'task_uuid': event.task.uuid,
              'task_title': event.task.title,
            },
          );
  }

  void _onChangeFilter(
    ChangeFilterEvent event,
    Emitter<AllTasksScreenState> emit,
  ) {
    emit(state.copyWith(filter: event.filter));
    MyLogger.infoLog('filter changed');
  }
}
