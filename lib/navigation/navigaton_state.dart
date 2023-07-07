import 'package:flutter/foundation.dart';
import 'package:todo/domain/models/task_model.dart';

class NavigationState with ChangeNotifier {
  bool _isAllTasksPage;
  TaskModel? _task;

  NavigationState(this._isAllTasksPage, this._task);

  bool get isAllTasksPage => _isAllTasksPage;

  TaskModel? get task => _task;

  set isAllTasksPage(bool val) {
    _isAllTasksPage = val;
    notifyListeners();
  }

  set task(TaskModel? val) {
    _task = val;
    notifyListeners();
  }

  @override
  String toString() => 'All Tasks: $_isAllTasksPage, task: $_task';
}
