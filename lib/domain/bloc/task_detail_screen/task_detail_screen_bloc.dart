import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/data/api/analytics_provider.dart';

import 'package:todo/domain/models/task_model.dart';
import 'package:todo/my_logger.dart';
import 'package:todo/l10n/locale_keys.g.dart';
import 'package:todo/domain/repository/tasks_repository.dart';
import 'package:uuid/uuid.dart';
import 'package:todo/data/api/constants/api_constants.dart';

part 'task_detail_screen_event.dart';

part 'task_detail_screen_state.dart';

class TaskDetailScreenBloc
    extends Bloc<TaskDetailScreenEvent, TaskDetailScreenState> {
  final TasksRepository _tasksRepository;
  final AnalyticsProvider _analyticsProvider;
  final String _deviceModel;

  TaskDetailScreenBloc({
    required TasksRepository tasksRepository,
    required AnalyticsProvider analyticsProvider,
    required String deviceModel,
    required TaskModel? editedTask,
  })  : _tasksRepository = tasksRepository,
        _analyticsProvider = analyticsProvider,
        _deviceModel = deviceModel,
        super(
          TaskDetailScreenState(
            editedTask: editedTask ??
                TaskModel(
                  uuid: const Uuid().v4(),
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
    int dateNowStamp = DateTime.now().millisecondsSinceEpoch;
    try {
      final taskToSave = (state.editedTask)?.copyWith(
        title: state.title ?? LocaleKeys.emptyTask.tr(),
        priority: state.priority ?? Priority.no,
        deadline: state.deadline,
        createdAt: state.createdAt ?? dateNowStamp,
        changedAt: dateNowStamp,
        lastUpdatedBy: _deviceModel,
      );
      await _tasksRepository.saveTask(taskToSave!);
      emit(state.copyWith(status: TaskDetailScreenStatus.success));
      MyLogger.infoLog('edit accepted');
      state.isNewTask
          ? _analyticsProvider.logEvent(
              ApiConstants.taskAdded,
              {
                'task_uuid': taskToSave.uuid,
                'task_text': taskToSave.title,
              },
            )
          : _analyticsProvider.logEvent(
              ApiConstants.taskChanged,
              {
                'task_uuid': taskToSave.uuid,
                'task_text': taskToSave.title,
              },
            );
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
    _analyticsProvider.logEvent(
      ApiConstants.taskDeleted,
      {'task_uuid': event.uuid},
    );
  }
}
