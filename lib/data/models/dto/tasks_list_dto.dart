import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:todo/data/models/dto/task_dto.dart';

part 'tasks_list_dto.freezed.dart';

part 'tasks_list_dto.g.dart';

@freezed
class TasksListDto with _$TasksListDto {
  const factory TasksListDto({
    required String status,
    required List<TaskDto> list,
    required int revision,
  }) = _TasksListDto;

  factory TasksListDto.fromJson(Map<String, dynamic> json) =>
      _$TasksListDtoFromJson(json);
}
