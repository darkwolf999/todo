import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/data/repositories/tasks_repository.dart';
import 'package:todo/my_logger.dart';

part 'task_detail_screen_event.dart';

part 'task_detail_screen_state.dart';

class TaskDetailScreenBloc
    extends Bloc<TaskDetailScreenEvent, TaskDetailScreenState> {
  final TasksRepository _tasksRepository;

  TaskDetailScreenBloc(this._tasksRepository)
      : super(const TaskDetailScreenState()) {
    on<EditAcceptedEvent>(_onEditAccepted);
    on<DeadlineSwitchedEvent>(_onDeadlineSwitched);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  Future<void> _onEditAccepted(
    EditAcceptedEvent event,
    Emitter<TaskDetailScreenState> emit,
  ) async {
    try {
      await _tasksRepository.saveTask(event.task);
      emit(state.copyWith(status: TaskDetailScreenStatus.success));
      MyLogger.infoLog('edit accepted');
    } catch (e) {
      emit(state.copyWith(status: TaskDetailScreenStatus.failure));
      MyLogger.errorLog('edit error', e);
    }
  }

  Future<void> _onDeleteTask(
    DeleteTaskEvent event,
    Emitter<TaskDetailScreenState> emit,
  ) async {
    await _tasksRepository.deleteTask(event.uuid);
    MyLogger.infoLog('task deleted');
  }

  Future<void> _onDeadlineSwitched(
    DeadlineSwitchedEvent event,
    Emitter<TaskDetailScreenState> emit,
  ) async {
    emit(state.copyWith(hasDeadline: !state.hasDeadline));
    MyLogger.infoLog('deadline switched');
  }
}
