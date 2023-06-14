part of 'all_tasks_screen_bloc.dart';

enum AllTasksScreenStatus { initial, success, failure }

class AllTasksScreenState extends Equatable {
  final AllTasksScreenStatus status;
  final List<TaskModel>? tasks;
  final int completedTasksCount;
  final TasksFilter filter;

  List<TaskModel> get filteredTasks => filter.applyFilter(tasks ?? []);

  const AllTasksScreenState({
    this.status = AllTasksScreenStatus.initial,
    this.tasks,
    this.completedTasksCount = 0,
    this.filter = TasksFilter.showAll,
  });

  AllTasksScreenState copyWith({
    AllTasksScreenStatus? status,
    List<TaskModel>? tasks,
    int? completedTasksCount,
    TasksFilter? filter,
  }) =>
      AllTasksScreenState(
        status: status ?? this.status,
        tasks: tasks ?? this.tasks,
        completedTasksCount: completedTasksCount ?? this.completedTasksCount,
        filter: filter ?? this.filter,
      );

  @override
  List<Object> get props => [
        status ?? '',
        tasks ?? '',
        completedTasksCount ?? '',
        filter ?? '',
      ];
}
