import 'package:flutter/foundation.dart';

class NavigationState with ChangeNotifier {
  bool _isAllTasksPage;
  int? _taskId;

  NavigationState(this._isAllTasksPage, this._taskId);

  bool get isAllTasksPage => _isAllTasksPage;

  int? get taskId => _taskId;

  set isAllTasksPage(bool val) {
    _isAllTasksPage = val;
    notifyListeners();
  }

  set taskId(int? val) {
    _taskId = val;
    notifyListeners();
  }

  @override
  String toString() => "All Tasks: $_isAllTasksPage, task: $_taskId";
}
