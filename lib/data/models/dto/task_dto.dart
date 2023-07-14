import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_dto.freezed.dart';

part 'task_dto.g.dart';

enum Importance { low, basic, important }

@freezed
class TaskDto with _$TaskDto {
  const factory TaskDto({
    required String id,
    required String text,
    required Importance importance,
    int? deadline,
    required bool done,
    String? color,
    @JsonKey(name: 'created_at') required int createdAt,
    @JsonKey(name: 'changed_at') required int changedAt,
    @JsonKey(name: 'last_updated_by') required String lastUpdatedBy,
  }) = _TaskDto;

  factory TaskDto.fromJson(Map<String, dynamic> json) =>
      _$TaskDtoFromJson(json);
}
