// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TasksListDto _$$_TasksListDtoFromJson(Map<String, dynamic> json) =>
    _$_TasksListDto(
      status: json['status'] as String,
      list: (json['list'] as List<dynamic>)
          .map((e) => TaskDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      revision: json['revision'] as int,
    );

Map<String, dynamic> _$$_TasksListDtoToJson(_$_TasksListDto instance) =>
    <String, dynamic>{
      'status': instance.status,
      'list': instance.list,
      'revision': instance.revision,
    };
