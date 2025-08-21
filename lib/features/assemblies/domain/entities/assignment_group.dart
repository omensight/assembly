import 'package:assembly/features/assemblies/domain/entities/assignment_completion.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment_group_assignee.dart';
import 'package:json_annotation/json_annotation.dart';

part 'assignment_group.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AssignmentGroup {
  final String id;
  final String assignmentId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<AssignmentGroupAssignee> assignees;
  final AssignmentCompletion? completion;

  AssignmentGroup({
    required this.id,
    required this.assignmentId,
    required this.createdAt,
    required this.updatedAt,
    required this.assignees,
    this.completion,
  });

  factory AssignmentGroup.fromJson(Map<String, dynamic> json) =>
      _$AssignmentGroupFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentGroupToJson(this);
}
