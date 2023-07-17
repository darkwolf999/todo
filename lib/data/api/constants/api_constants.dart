class ApiConstants {
  //backend
  static const String host = 'beta.mrdekk.ru';
  static const String listEndpoint = '/list/';
  static const int connectTimeout = 10;

  //sprefs
  static const sharedPrefsTasksKey = 'allTasks';
  static const shPrefsRevisionKey = 'revision';
  static const defaultRevision = 0;

  //firebase analytics
  static const String taskAdded = 'task_added';
  static const String taskChanged = 'task_changed';
  static const String taskCompleted = 'task_completed';
  static const String taskUncompleted = 'task_uncompleted';
  static const String taskDeleted = 'task_deleted';
  static const String allTasksScreen = 'AllTasksScreen';
  static const String taskDetailScreen = 'TaskDetailScreen';
}
