import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.g.dart';

part 'task_model.freezed.dart';

enum Priority { no, low, high }

@freezed
class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String uuid,
    required String title,
    required bool isDone,
    required Priority priority,
    DateTime? deadline,
    String? color,
    required int createdAt,
    required int changedAt,
    required String lastUpdatedBy,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
