import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/bloc/all_tasks_screen/all_tasks_screen_bloc.dart';
import 'package:todo/data/models/taskModel.dart';

import 'package:todo/repositories/tasks_repository.dart';

part 'task_detail_screen_event.dart';

part 'task_detail_screen_state.dart';

class TaskDetailScreenBloc
    extends Bloc<TaskDetailScreenEvent, TaskDetailScreenState> {
  final TasksRepository _tasksRepository;

  TaskDetailScreenBloc(this._tasksRepository) : super(TaskDetailScreenState()) {
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
    } catch (e) {
      emit(state.copyWith(status: TaskDetailScreenStatus.failure));
    }
  }

  Future<void> _onDeleteTask(
    DeleteTaskEvent event,
    Emitter<TaskDetailScreenState> emit,
  ) async {
    await _tasksRepository.deleteTask(event.uuid);
  }

  Future<void> _onDeadlineSwitched(
    DeadlineSwitchedEvent event,
    Emitter<TaskDetailScreenState> emit,
  ) async {
    emit(state.copyWith(hasDeadline: !state.hasDeadline));
  }
}
