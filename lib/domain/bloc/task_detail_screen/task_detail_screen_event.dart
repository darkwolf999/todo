part of 'task_detail_screen_bloc.dart';

abstract class TaskDetailScreenEvent extends Equatable {
  const TaskDetailScreenEvent();

  @override
  List<Object> get props => [];
}

class TitleChangedEvent extends TaskDetailScreenEvent {
  final String title;

  const TitleChangedEvent(this.title);

  @override
  List<Object> get props => [title];
}

class PriorityChangedEvent extends TaskDetailScreenEvent {
  final Priority priority;

  const PriorityChangedEvent(this.priority);

  @override
  List<Object> get props => [priority];
}

class DeadlineChangedEvent extends TaskDetailScreenEvent {
  final DateTime? deadline;

  const DeadlineChangedEvent(this.deadline);

  @override
  List<Object> get props => [deadline ?? ''];
}

class EditAcceptedEvent extends TaskDetailScreenEvent {
  const EditAcceptedEvent();
}

class DeleteTaskEvent extends TaskDetailScreenEvent {
  final String uuid;

  const DeleteTaskEvent(this.uuid);

  @override
  List<Object> get props => [uuid];
}
