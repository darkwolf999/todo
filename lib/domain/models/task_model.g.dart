// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      uuid: json['uuid'] as String?,
      title: json['title'] as String,
      isDone: json['isDone'] as bool,
      priority: $enumDecode(_$PriorityEnumMap, json['priority']),
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      color: json['color'] as String?,
      createdAt: json['createdAt'] as int,
      changedAt: json['changedAt'] as int,
      lastUpdatedBy: json['lastUpdatedBy'] as String,
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'title': instance.title,
      'isDone': instance.isDone,
      'priority': _$PriorityEnumMap[instance.priority]!,
      'deadline': instance.deadline?.toIso8601String(),
      'color': instance.color,
      'createdAt': instance.createdAt,
      'changedAt': instance.changedAt,
      'lastUpdatedBy': instance.lastUpdatedBy,
    };

const _$PriorityEnumMap = {
  Priority.no: 'no',
  Priority.low: 'low',
  Priority.high: 'high',
};
