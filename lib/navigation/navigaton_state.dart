import 'package:flutter/foundation.dart';
import 'package:todo/domain/models/task_model.dart';

class NavigationState with ChangeNotifier {
  bool _isAllTasksPage;
  TaskModel? _task;
  int? _taskIndex;

  NavigationState(this._isAllTasksPage, this._task, this._taskIndex);

  bool get isAllTasksPage => _isAllTasksPage;

  TaskModel? get task => _task;

  int? get taskIndex => _taskIndex;

  set isAllTasksPage(bool val) {
    _isAllTasksPage = val;
    notifyListeners();
  }

  set task(TaskModel? val) {
    _task = val;
    notifyListeners();
  }

  set taskIndex(int? val) {
    _taskIndex = val;
    notifyListeners();
  }

  @override
  String toString() =>
      'All Tasks: $_isAllTasksPage, task: $_task,  taskIndex: $_taskIndex';
}
