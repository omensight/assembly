import 'package:json_annotation/json_annotation.dart';

part 'assignment_cycle.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AssignmentCycle {
  final String id;
  final String assignmentId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime startDateAndTime;
  final String? activeGroupId;
  final DateTime? nextUpdate;

  AssignmentCycle({
    required this.id,
    required this.assignmentId,
    required this.createdAt,
    required this.updatedAt,
    required this.startDateAndTime,
    this.activeGroupId,
    this.nextUpdate,
  });

  Map<String, dynamic> toJson() => _$AssignmentCycleToJson(this);

  factory AssignmentCycle.fromJson(Map<String, dynamic> json) =>
      _$AssignmentCycleFromJson(json);
}
