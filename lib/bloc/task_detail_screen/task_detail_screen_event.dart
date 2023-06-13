part of 'task_detail_screen_bloc.dart';

abstract class TaskDetailScreenEvent extends Equatable {
  const TaskDetailScreenEvent();

  @override
  List<Object> get props => [];
}

class EditAccepted extends TaskDetailScreenEvent {
  const EditAccepted();
}