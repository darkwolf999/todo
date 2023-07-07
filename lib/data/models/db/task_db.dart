import 'package:isar/isar.dart';

import 'package:todo/helpers/fast_hash.dart';

part 'task_db.g.dart';

enum Priority { no, low, high }

@collection
class DBTask {
  Id get isarId => FastHash.generate(uuid);
  String uuid;
  final String title;
  final bool isDone;
  @enumerated
  final Priority priority;
  final int? deadline;
  final String? color;
  final int createdAt;
  final int changedAt;
  final String lastUpdatedBy;

  DBTask({
    required this.uuid,
    required this.title,
    required this.isDone,
    required this.priority,
    this.deadline,
    this.color,
    required this.createdAt,
    required this.changedAt,
    required this.lastUpdatedBy,
  });
}
