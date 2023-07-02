part of 'task_detail_screen_bloc.dart';

enum TaskDetailScreenStatus { initial, success, failure }

class TaskDetailScreenState extends Equatable {
  final TaskDetailScreenStatus status;
  final TaskModel? editedTask;
  final String? title;
  final Priority? priority;
  final DateTime? deadline;
  final int? createdAt;
  final bool? isNewTask;

  const TaskDetailScreenState({
    this.status = TaskDetailScreenStatus.initial,
    this.editedTask,
    this.title,
    this.priority,
    this.deadline,
    this.createdAt,
    this.isNewTask,
  });

  TaskDetailScreenState copyWith({
    TaskDetailScreenStatus? status,
    ValueGetter<TaskModel?>? editedTask,
    ValueGetter<String?>? title,
    ValueGetter<Priority?>? priority,
    ValueGetter<DateTime?>? deadline,
    ValueGetter<int?>? createdAt,
    ValueGetter<bool?>? isNewTask,
  }) =>
      TaskDetailScreenState(
        status: status ?? this.status,
        editedTask: editedTask != null ? editedTask() : this.editedTask,
        title: title != null ? title() : this.title,
        priority: priority != null ? priority() : this.priority,
        deadline: deadline != null ? deadline() : this.deadline,
        createdAt: createdAt != null ? createdAt() : this.createdAt,
        isNewTask: isNewTask != null ? isNewTask() : this.isNewTask,
      );

  @override
  List<Object> get props => [
        status ?? '',
        editedTask ?? '',
        title ?? '',
        priority ?? '',
        deadline ?? '',
        createdAt ?? '',
        isNewTask ?? '',
      ];
}
