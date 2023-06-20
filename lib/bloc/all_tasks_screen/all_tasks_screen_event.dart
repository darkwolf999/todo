part of 'all_tasks_screen_bloc.dart';

abstract class AllTasksScreenEvent extends Equatable {
  const AllTasksScreenEvent();

  @override
  List<Object> get props => [];
}

class SubscribeStreamEvent extends AllTasksScreenEvent {
  const SubscribeStreamEvent();
}

class AddTaskEvent extends AllTasksScreenEvent {
  final TaskModel task;

  const AddTaskEvent(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteTaskEvent extends AllTasksScreenEvent {
  final String uuid;

  const DeleteTaskEvent(this.uuid);

  @override
  List<Object> get props => [uuid];
}

class CompleteTaskEvent extends AllTasksScreenEvent {
  final TaskModel task;

  const CompleteTaskEvent(this.task);

  @override
  List<Object> get props => [task];
}

class ChangeFilterEvent extends AllTasksScreenEvent {
  final TasksFilter filter;

  const ChangeFilterEvent(this.filter);

  @override
  List<Object> get props => [filter];
}
