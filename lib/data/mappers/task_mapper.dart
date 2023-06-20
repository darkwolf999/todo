import '../dto/task_dto.dart';
//import '../models/task_model.dart' as model;
import '../models/task_model.dart';

/// Преобразовываем [TaskDto] в [TaskModel]
extension TaskFromToDomain on TaskDto{
  TaskModel toDomain(){
    return TaskModel(
      uuid: id,
      title: text,
      isDone: done,
      priority: toDomainPriority(importance),
      deadline: DateTime.now(), //todo переделать
    );
  }
}

Priority toDomainPriority(Importance priority) {
  switch (priority) {
    case Importance.low:
      return Priority.low;
    case Importance.basic:
      return Priority.no;
    case Importance.important:
      return Priority.high;
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