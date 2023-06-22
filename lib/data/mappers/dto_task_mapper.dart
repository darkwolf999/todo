import '../dto/task_dto.dart';

//import '../models/task_model.dart' as model;
import '../models/task_model.dart';

/// Преобразовываем [TaskDto] в [TaskModel]
extension TaskFromDtoToDomain on TaskDto {
  TaskModel toDomain() {
    return TaskModel(
      uuid: id,
      title: text,
      isDone: done,
      priority: toDomainPriority(importance),
      //todo переделать
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
      //todo переделать
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

// extension TaskFromToDomain on TaskDto{
//   model.TaskModel toDomain(){
//     return model.TaskModel(
//       uuid: id,
//       title: text,
//       isDone: done,
//       priority: toDomainPriority(importance),
//       deadline: DateTime.now(), //todo переделать
//     );
//   }
// }

// model.Priority toDomainPriority(Priority priority) {
//   switch (priority) {
//     case Priority.low:
//       return model.Priority.low;
//     case Priority.basic:
//       return model.Priority.no;
//     case Priority.important:
//       return model.Priority.high;
//   }
// }
