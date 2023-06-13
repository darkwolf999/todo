import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'taskModel.g.dart';

enum Priority {
  no,
  low,
  high,
}

@JsonSerializable()
class TaskModel extends Equatable {
  final String? uuid;
  final String title;
  final bool isDone;
  final Priority? priority;

  const TaskModel({
    this.uuid,
    required this.title,
    required this.isDone,
    this.priority,
  });

  TaskModel copyWith({
    String? uuid,
    String? title,
    bool? isDone,
    Priority? priority,
  }) {
    return TaskModel(
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      priority: priority ?? this.priority,
    );
  }

  static TaskModel fromJson(Map<String, dynamic>  json) => _$TaskModelFromJson(json);

  Map<String, dynamic>  toJson() => _$TaskModelToJson(this);

  @override
  List<Object?> get props => [
        uuid ?? '',
        title ?? '',
        isDone ?? '',
        priority ?? '',
      ];
}
