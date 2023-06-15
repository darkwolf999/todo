part of 'task_detail_screen_bloc.dart';

enum TaskDetailScreenStatus { initial, success, failure }

class TaskDetailScreenState extends Equatable {
  final TaskDetailScreenStatus status;
  final TaskModel? editedTask;
  final bool hasDeadline;

  const TaskDetailScreenState({
    this.status = TaskDetailScreenStatus.initial,
    this.editedTask,
    this.hasDeadline = false,
  });

  TaskDetailScreenState copyWith({
    TaskDetailScreenStatus? status,
    TaskModel? editedTask,
    bool? hasDeadline,
  }) =>
      TaskDetailScreenState(
        status: status ?? this.status,
        editedTask: editedTask ?? this.editedTask,
        hasDeadline: hasDeadline ?? this.hasDeadline,
      );

  @override
  List<Object> get props => [
        status ?? '',
        editedTask ?? '',
        hasDeadline ?? '',
      ];
}
