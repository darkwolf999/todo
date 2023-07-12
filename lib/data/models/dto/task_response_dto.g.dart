// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskResponseDto _$$_TaskResponseDtoFromJson(Map<String, dynamic> json) =>
    _$_TaskResponseDto(
      status: json['status'] as String,
      taskDto: TaskDto.fromJson(json['element'] as Map<String, dynamic>),
      revision: json['revision'] as int,
    );

Map<String, dynamic> _$$_TaskResponseDtoToJson(_$_TaskResponseDto instance) =>
    <String, dynamic>{
      'status': instance.status,
      'element': instance.taskDto,
      'revision': instance.revision,
    };
