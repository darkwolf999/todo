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
  final Priority? priority;
  final DateTime? deadline;

  TaskModel({
    String? uuid,
    required this.title,
    required this.isDone,
    this.priority,
    this.deadline,
  }) : uuid = uuid ?? const Uuid().v4();

  TaskModel copyWith({
    String? uuid,
    String? title,
    bool? isDone,
    Priority? priority,
    DateTime? deadline,
  }) {
    return TaskModel(
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      priority: priority ?? this.priority,
      deadline: deadline ?? this.deadline,
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
      ];
}
