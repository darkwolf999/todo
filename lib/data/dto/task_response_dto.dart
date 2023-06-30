import 'package:json_annotation/json_annotation.dart';
import 'package:todo/data/dto/task_dto.dart';

part 'task_response_dto.g.dart';

@JsonSerializable()
class TaskResponseDto {
  final String status;
  @JsonKey(name: 'element')
  final TaskDto taskDto;
  final int revision;

  TaskResponseDto({
    required this.status,
    required this.taskDto,
    required this.revision,
  });

  static TaskResponseDto fromJson(Map<String, dynamic> json) =>
      _$TaskResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TaskResponseDtoToJson(this);
}
