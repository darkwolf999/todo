import 'package:todo/data/models/dto/task_response_dto.dart';
import 'package:todo/data/models/dto/task_dto.dart';
import 'package:todo/data/models/dto/tasks_list_dto.dart';

abstract class NetworkTasksApi {
  Future<TasksListDto> fetchTasks();

  Future<TaskResponseDto> addNewTask(TaskDto taskDto);

  Future<TaskResponseDto> editTask(TaskDto taskDto);

  Future<TaskResponseDto> deleteTask(String uuid);

  Future<TaskResponseDto> fetchSingleTask(String uuid);

  Future<TasksListDto> refreshTasks(List<TaskDto> tasksDto);
}
