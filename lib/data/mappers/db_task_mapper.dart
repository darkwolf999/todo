import '../db/task_db.dart' as db;
import '../models/task_model.dart';

/// Преобразовываем [TaskDB] в [TaskModel]
extension TaskFromDBToDomain on db.TaskDB {
  TaskModel toDomain() {
    return TaskModel(
      uuid: uuid,
      title: title,
      isDone: isDone,
      priority: toDomainPriority(priority),
      deadline: deadline,
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
  db.TaskDB toDB() {
    return db.TaskDB(
      uuid: uuid,
      title: title,
      isDone: isDone,
      priority: toDBPriority(priority),
      deadline: deadline,
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