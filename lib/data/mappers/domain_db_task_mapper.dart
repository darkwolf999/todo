import 'package:todo/data/db/task_db.dart' as db;
import 'package:todo/data/models/task_model.dart';

/// Преобразовываем [TaskDB] в [TaskModel]
extension TaskFromDBToDomain on db.DBTask {
  TaskModel toDomain() {
    return TaskModel(
      uuid: uuid,
      title: title,
      isDone: isDone,
      priority: toDomainPriority(priority),
      deadline: deadline != null
          ? DateTime.fromMillisecondsSinceEpoch(deadline!)
          : null,
      color: color,
      createdAt: createdAt,
      changedAt: changedAt,
      lastUpdatedBy: lastUpdatedBy,
    );
  }
}

Priority toDomainPriority(db.Priority priority) {
  switch (priority) {
    case db.Priority.low:
      return Priority.low;
    case db.Priority.no:
      return Priority.no;
    case db.Priority.high:
      return Priority.high;
  }
}

/// Преобразовываем [TaskModel] в [TaskDB]
extension TaskFromDomainToDB on TaskModel {
  db.DBTask toDB() {
    return db.DBTask(
      uuid: uuid,
      title: title,
      isDone: isDone,
      priority: toDBPriority(priority),
      deadline: deadline?.millisecondsSinceEpoch,
      color: color,
      createdAt: createdAt,
      changedAt: changedAt,
      lastUpdatedBy: lastUpdatedBy,
    );
  }
}

db.Priority toDBPriority(Priority priority) {
  switch (priority) {
    case Priority.low:
      return db.Priority.low;
    case Priority.no:
      return db.Priority.no;
    case Priority.high:
      return db.Priority.high;
  }
}
