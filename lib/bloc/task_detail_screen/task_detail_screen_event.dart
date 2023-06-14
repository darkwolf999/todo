part of 'task_detail_screen_bloc.dart';

abstract class TaskDetailScreenEvent extends Equatable {
  const TaskDetailScreenEvent();

  @override
  List<Object> get props => [];
}

class EditAcceptedEvent extends TaskDetailScreenEvent {
  final TaskModel task;

  const EditAcceptedEvent(this.task);

  @override
  List<Object> get props => [task];
}

class DeadlineSwitchedEvent extends TaskDetailScreenEvent {
  const DeadlineSwitchedEvent();
}