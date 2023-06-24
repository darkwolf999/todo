import 'package:json_annotation/json_annotation.dart';
import 'package:todo/data/dto/task_dto.dart';

part 'tasks_list_dto.g.dart';

@JsonSerializable()
class TasksListDto {
  final String status;
  List<TaskDto> list;
  final int revision;

  TasksListDto({
    required this.status,
    required this.list,
    required this.revision,
  });

  static TasksListDto fromJson(Map<String, dynamic> json) =>
      _$TasksListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TasksListDtoToJson(this);
}
