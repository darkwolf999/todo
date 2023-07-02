// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskResponseDto _$TaskResponseDtoFromJson(Map<String, dynamic> json) =>
    TaskResponseDto(
      status: json['status'] as String,
      taskDto: TaskDto.fromJson(json['element'] as Map<String, dynamic>),
      revision: json['revision'] as int,
    );

Map<String, dynamic> _$TaskResponseDtoToJson(TaskResponseDto instance) =>
    <String, dynamic>{
      'status': instance.status,
      'element': instance.taskDto,
      'revision': instance.revision,
    };
