// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasksListDto _$TasksListDtoFromJson(Map<String, dynamic> json) => TasksListDto(
      status: json['status'] as String,
      list: (json['list'] as List<dynamic>)
          .map((e) => TaskDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      revision: json['revision'] as int,
    );

Map<String, dynamic> _$TasksListDtoToJson(TasksListDto instance) =>
    <String, dynamic>{
      'status': instance.status,
      'list': instance.list,
      'revision': instance.revision,
    };
