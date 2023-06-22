import 'package:todo/data/dto/task_dto.dart';
import 'package:todo/data/models/task_model.dart';

/// Преобразовываем [TaskDto] в [TaskModel]
extension TaskFromDtoToDomain on TaskDto {
  TaskModel toDomain() {
    return TaskModel(
      uuid: id,
      title: text,
      isDone: done,
      priority: toDomainPriority(importance),
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

Priority toDomainPriority(Importance importance) {
  switch (importance) {
    case Importance.low:
      return Priority.low;
    case Importance.basic:
      return Priority.no;
    case Importance.important:
      return Priority.high;
  }
}

/// Преобразовываем [TaskModel] в [TaskDto]
extension TaskFromDomainToDto on TaskModel {
  TaskDto toDto() {
    return TaskDto(
      id: uuid,
      text: title,
      done: isDone,
      importance: toDtoImportance(priority),
      deadline: deadline?.millisecondsSinceEpoch,
      color: color,
      createdAt: createdAt,
      changedAt: changedAt,
      lastUpdatedBy: lastUpdatedBy,
    );
  }
}

Importance toDtoImportance(Priority priority) {
  switch (priority) {
    case Priority.low:
      return Importance.low;
    case Priority.no:
      return Importance.basic;
    case Priority.high:
      return Importance.important;
  }
}
