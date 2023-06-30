import 'package:todo/data/db/task_db.dart' as db;
import 'package:todo/data/dto/task_dto.dart';
import 'package:todo/data/db/task_db.dart';

/// Преобразовываем [DBTask] в [TaskDto]
extension TaskFromDBToDto on db.DBTask {
  TaskDto toDto() {
    return TaskDto(
      id: uuid,
      text: title,
      done: isDone,
      importance: toDtoImportance(priority),
      deadline: deadline,
      color: color,
      createdAt: createdAt,
      changedAt: changedAt,
      lastUpdatedBy: lastUpdatedBy,
    );
  }
}

Importance toDtoImportance(db.Priority priority) {
  switch (priority) {
    case db.Priority.low:
      return Importance.low;
    case db.Priority.no:
      return Importance.basic;
    case db.Priority.high:
      return Importance.important;
  }
}

/// Преобразовываем [TaskDto] в [DBTask]
extension TaskFromDtoToDB on TaskDto {
  db.DBTask toDB() {
    return db.DBTask(
      uuid: id,
      title: text,
      isDone: done,
      priority: toDBPriority(importance),
      deadline: deadline,
      color: color,
      createdAt: createdAt,
      changedAt: changedAt,
      lastUpdatedBy: lastUpdatedBy,
    );
  }
}

db.Priority toDBPriority(Importance importance) {
  switch (importance) {
    case Importance.low:
      return db.Priority.low;
    case Importance.basic:
      return db.Priority.no;
    case Importance.important:
      return db.Priority.high;
  }
}
