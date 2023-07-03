import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import 'package:todo/domain/models/task_model.dart';
import 'package:todo/data/repositories/tasks_repository_impl.dart';
import 'package:todo/helpers/device_info.dart';
import 'package:todo/my_logger.dart';
import 'package:todo/l10n/locale_keys.g.dart';

import '../../repository/tasks_repository.dart';

part 'task_detail_screen_event.dart';

part 'task_detail_screen_state.dart';

class TaskDetailScreenBloc
    extends Bloc<TaskDetailScreenEvent, TaskDetailScreenState> {
  final TasksRepository _tasksRepository;

  TaskDetailScreenBloc({
    required TasksRepository tasksRepository,
    required TaskModel? editedTask,
  })  : _tasksRepository = tasksRepository,
        super(
          TaskDetailScreenState(
            editedTask: editedTask ??
                TaskModel(
                  title: LocaleKeys.emptyTask.tr(),
                  isDone: false,
                  priority: Priority.no,
                  createdAt: 0,
                  changedAt: 0,
                  lastUpdatedBy: '',
                ),
            title: editedTask?.title,
            priority: editedTask?.priority,
            deadline: editedTask?.deadline,
            createdAt: editedTask?.createdAt,
            isNewTask: editedTask == null ? true : false,
          ),
        ) {
    on<TitleChangedEvent>(_onTitleChanged);
    on<PriorityChangedEvent>(_onPriorityChanged);
    on<DeadlineChangedEvent>(_onDeadlineChanged);
    on<EditAcceptedEvent>(_onEditAccepted);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  String deviceModel = GetIt.I.get(instanceName: 'deviceModel');

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

  Future<void> _onEditAccepted(
    EditAcceptedEvent event,
    Emitter<TaskDetailScreenState> emit,
  ) async {
    deviceModel = deviceModel;
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
