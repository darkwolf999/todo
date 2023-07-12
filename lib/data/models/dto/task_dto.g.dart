// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskDto _$$_TaskDtoFromJson(Map<String, dynamic> json) => _$_TaskDto(
      id: json['id'] as String,
      text: json['text'] as String,
      importance: $enumDecode(_$ImportanceEnumMap, json['importance']),
      deadline: json['deadline'] as int?,
      done: json['done'] as bool,
      color: json['color'] as String?,
      createdAt: json['created_at'] as int,
      changedAt: json['changed_at'] as int,
      lastUpdatedBy: json['last_updated_by'] as String,
    );

Map<String, dynamic> _$$_TaskDtoToJson(_$_TaskDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'importance': _$ImportanceEnumMap[instance.importance]!,
      'deadline': instance.deadline,
      'done': instance.done,
      'color': instance.color,
      'created_at': instance.createdAt,
      'changed_at': instance.changedAt,
      'last_updated_by': instance.lastUpdatedBy,
    };

const _$ImportanceEnumMap = {
  Importance.low: 'low',
  Importance.basic: 'basic',
  Importance.important: 'important',
};
