import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'task_model.g.dart';

enum Priority { no, low, high }

@JsonSerializable()
class TaskModel extends Equatable {
  final String uuid;
  final String title;
  final bool isDone;
  final Priority priority;
  final DateTime? deadline;
  final String? color;
  final int createdAt;
  final int changedAt;
  final String lastUpdatedBy;

  TaskModel({
    String? uuid,
    required this.title,
    required this.isDone,
    required this.priority,
    this.deadline,
    this.color,
    required this.createdAt,
    required this.changedAt,
    required this.lastUpdatedBy,
  }) : uuid = uuid ?? const Uuid().v4();

  TaskModel copyWith({
    String? uuid,
    String? title,
    bool? isDone,
    Priority? priority,
    DateTime? deadline,
    String? color,
    int? createdAt,
    int? changedAt,
    String? lastUpdatedBy,
  }) {
    return TaskModel(
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      priority: priority ?? this.priority,
      deadline: deadline ?? this.deadline,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
      lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
    );
  }

  static TaskModel fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  @override
  List<Object?> get props => [
        uuid ?? '',
        title ?? '',
        isDone ?? '',
        priority ?? '',
        deadline ?? '',
        color ?? '',
        createdAt ?? '',
        changedAt ?? '',
        lastUpdatedBy ?? '',
      ];
}
