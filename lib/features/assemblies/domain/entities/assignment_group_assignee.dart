import 'package:assembly/features/assemblies/domain/entities/assembly_member.dart';
import 'package:json_annotation/json_annotation.dart';
part 'assignment_group_assignee.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AssignmentGroupAssignee {
  final String id;
  final String assignmentGroupId;
  final String assemblyMemberId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final AssemblyMember assemblyMember;

  AssignmentGroupAssignee({
    required this.id,
    required this.assignmentGroupId,
    required this.assemblyMemberId,
    required this.createdAt,
    required this.updatedAt,
    required this.assemblyMember,
  });

  factory AssignmentGroupAssignee.fromJson(Map<String, dynamic> json) =>
      _$AssignmentGroupAssigneeFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentGroupAssigneeToJson(this);
}
