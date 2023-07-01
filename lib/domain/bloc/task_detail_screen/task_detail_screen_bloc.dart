import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:todo/data/models/task_model.dart';
import 'package:todo/data/repositories/tasks_repository.dart';
import 'package:todo/helpers/device_info.dart';
import 'package:todo/my_logger.dart';
import 'package:todo/l10n/locale_keys.g.dart';

part 'task_detail_screen_event.dart';

part 'task_detail_screen_state.dart';

class TaskDetailScreenBloc
    extends Bloc<TaskDetailScreenEvent, TaskDetailScreenState> {
  final TasksRepository _tasksRepository;

  TaskDetailScreenBloc(this._tasksRepository)
      : super(const TaskDetailScreenState()) {
    on<StartEditingTaskEvent>(_onStartEditingTask);
    on<TitleChangedEvent>(_onTitleChanged);
    on<PriorityChangedEvent>(_onPriorityChanged);
    on<DeadlineChangedEvent>(_onDeadlineChanged);
    on<FinishEditingEvent>(_onFinishEditing);
    on<EditAcceptedEvent>(_onEditAccepted);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  String deviceModel = '';

  Future<void> _onStartEditingTask(
    StartEditingTaskEvent event,
    Emitter<TaskDetailScreenState> emit,
  ) async {
    emit(
      state.copyWith(
        editedTask: () =>
            event.task ??
            TaskModel(
              title: LocaleKeys.emptyTask.tr(),
              isDone: false,
              priority: Priority.no,
              createdAt: 0,
              changedAt: 0,
              lastUpdatedBy: '',
            ),
        title: () => event.task?.title,
        priority: () => event.task?.priority,
        deadline: () => event.task?.deadline,
        createdAt: () => event.task?.createdAt,
      ),
    );
    deviceModel = await DeviceInfo.getDeviceModel();
    MyLogger.infoLog('start editing task');
  }

  void _onTitleChanged(
    TitleChangedEvent event,
    Emitter<TaskDetailScreenState> emit,
  ) {
    emit(state.copyWith(title: () => event.title));
  }

  void _onPriorityChanged(
    PriorityChangedEvent event,
    Emitter<TaskDetailScreenState> emit,
  ) {
    emit(state.copyWith(priority: () => event.priority));
  }

  void _onDeadlineChanged(
    DeadlineChangedEvent event,
    Emitter<TaskDetailScreenState> emit,
  ) {
    emit(state.copyWith(deadline: () => event.deadline));
  }

  void _onFinishEditing(
    FinishEditingEvent event,
    Emitter<TaskDetailScreenState> emit,
  ) {
    emit(
      state.copyWith(
        editedTask: () => null,
        title: () => null,
        priority: () => null,
        deadline: () => null,
        createdAt: () => null,
      ),
    );
    MyLogger.infoLog('edit finish');
  }

  Future<void> _onEditAccepted(
    EditAcceptedEvent event,
    Emitter<TaskDetailScreenState> emit,
  ) async {
    int dateNowStamp = DateTime.now().millisecondsSinceEpoch;
    try {
      final taskToSave = (state.editedTask)?.copyWith(
        title: state.title,
        priority: state.priority,
        deadline: () => state.deadline,
        createdAt: state.createdAt ?? dateNowStamp,
        changedAt: dateNowStamp,
        lastUpdatedBy: deviceModel,
      );
      await _tasksRepository.saveTask(taskToSave!);
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
}
