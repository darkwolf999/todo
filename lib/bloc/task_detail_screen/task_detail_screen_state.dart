part of 'task_detail_screen_bloc.dart';

enum TaskDetailScreenStatus { initial, success, failure }

class TaskDetailScreenState extends Equatable {
  final TaskDetailScreenStatus status;
  final TaskModel? editedTask;

  TaskDetailScreenState({
    this.status = TaskDetailScreenStatus.initial,
    this.editedTask,
  });

  TaskDetailScreenState copyWith({
    TaskDetailScreenStatus? status,
    TaskModel? editedTask,
  }) =>
      TaskDetailScreenState(
        status: status ?? this.status,
        editedTask: editedTask ?? this.editedTask,
      );

  @override
  List<Object> get props => [
        status ?? '',
        editedTask ?? '',
      ];
}
