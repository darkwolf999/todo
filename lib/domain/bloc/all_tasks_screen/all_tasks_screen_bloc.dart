import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/data/repositories/tasks_repository.dart';
import 'package:todo/presentation/models/tasks_filter.dart';
import 'package:todo/my_logger.dart';

part 'all_tasks_screen_event.dart';

part 'all_tasks_screen_state.dart';

class AllTasksScreenBloc
    extends Bloc<AllTasksScreenEvent, AllTasksScreenState> {
  final TasksRepository _tasksRepository;
  bool isCompletedTasksShown = false;

  AllTasksScreenBloc(this._tasksRepository)
      : super(const AllTasksScreenState()) {
    on<SubscribeStreamEvent>(_onSubscribeStream);
    on<AddTaskEvent>(_onAddTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<CompleteTaskEvent>(_onCompleteTask);
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

  Future<void> _onAddTask(
    AddTaskEvent event,
    Emitter<AllTasksScreenState> emit,
  ) async {
    emit(state.copyWith(status: AllTasksScreenStatus.initial));
    try {
      await _tasksRepository.saveTask(event.task);
      emit(state.copyWith(status: AllTasksScreenStatus.success));
      MyLogger.infoLog('task added');
    } catch (e) {
      MyLogger.errorLog('task add error', e);
      emit(state.copyWith(status: AllTasksScreenStatus.failure));
    }
  }

  Future<void> _onDeleteTask(
    DeleteTaskEvent event,
    Emitter<AllTasksScreenState> emit,
  ) async {
    await _tasksRepository.deleteTask(event.uuid);
    MyLogger.infoLog('task after deleting ${state.tasks}');
  }

  Future<void> _onCompleteTask(
    CompleteTaskEvent event,
    Emitter<AllTasksScreenState> emit,
  ) async {
    final completedTask = event.task.copyWith(isDone: !event.task.isDone);
    await _tasksRepository.saveTask(completedTask);
    MyLogger.infoLog('task after completion: ${state.tasks}');
    MyLogger.infoLog('completed count: ${state.completedTasksCount}');
  }

  void _onChangeFilter(
    ChangeFilterEvent event,
    Emitter<AllTasksScreenState> emit,
  ) {
    emit(state.copyWith(filter: event.filter));
    MyLogger.infoLog('filter changed');
  }
}
