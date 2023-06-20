// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      uuid: json['uuid'] as String?,
      title: json['title'] as String,
      isDone: json['isDone'] as bool,
      priority: $enumDecodeNullable(_$PriorityEnumMap, json['priority']),
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'title': instance.title,
      'isDone': instance.isDone,
      'priority': _$PriorityEnumMap[instance.priority],
      'deadline': instance.deadline?.toIso8601String(),
    };

const _$PriorityEnumMap = {
  Priority.no: 'no',
  Priority.low: 'low',
  Priority.high: 'high',
};
