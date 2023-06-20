import 'package:json_annotation/json_annotation.dart';

part 'task_dto.g.dart';

enum Importance { low, basic, important }

@JsonSerializable()
class TaskDto {
  final String id;
  final String text;
  final Importance importance;
  final int? deadline;
  final bool done;
  final String? color;
  @JsonKey(name: 'created_at')
  final int createdAt;
  @JsonKey(name: 'changed_at')
  final int changedAt;
  @JsonKey(name: 'last_updated_by')
  final String lastUpdatedBy;

  TaskDto({
    required this.id,
    required this.text,
    required this.importance,
    this.deadline,
    required this.done,
    this.color,
    required this.createdAt,
    required this.changedAt,
    required this.lastUpdatedBy,
  });

  // TaskModel copyWith({
  //   String? uuid,
  //   String? title,
  //   bool? isDone,
  //   Priority? priority,
  //   DateTime? deadline,
  // }) {
  //   return TaskModel(
  //     uuid: uuid ?? this.uuid,
  //     title: title ?? this.title,
  //     isDone: isDone ?? this.isDone,
  //     priority: priority ?? this.priority,
  //     deadline: deadline ?? this.deadline,
  //   );
  // }

  static TaskDto fromJson(Map<String, dynamic> json) =>
      _$TaskDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TaskDtoToJson(this);

  // @override
  // List<Object?> get props => [
  //   uuid ?? '',
  //   title ?? '',
  //   isDone ?? '',
  //   priority ?? '',
  //   deadline ?? '',
  // ];
}
