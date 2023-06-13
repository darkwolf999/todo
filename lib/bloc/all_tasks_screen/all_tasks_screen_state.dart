part of 'all_tasks_screen_bloc.dart';

enum AllTasksScreenStatus { initial, success, failure }

class AllTasksScreenState extends Equatable {
  final AllTasksScreenStatus status;
  final List<TaskModel>? tasks;

  const AllTasksScreenState({
    this.status = AllTasksScreenStatus.initial,
    this.tasks,
  });

  AllTasksScreenState copyWith({
    AllTasksScreenStatus? status,
    List<TaskModel>? tasks,
  }) =>
      AllTasksScreenState(
        status: status ?? this.status,
        tasks: tasks ?? this.tasks,
      );

  @override
  List<Object> get props => [
        status ?? '',
        tasks ?? '',
      ];
}
