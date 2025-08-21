// lib/features/assemblies/domain/entities/assignment_completion.dart
import 'package:json_annotation/json_annotation.dart';

part 'assignment_completion.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AssignmentCompletion {
  final String id;
  final String assignmentId;
  final String assignmentGroupId;
  final String memberIssuerId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isConfirmed;

  const AssignmentCompletion({
    required this.id,
    required this.assignmentId,
    required this.assignmentGroupId,
    required this.memberIssuerId,
    required this.createdAt,
    required this.updatedAt,
    required this.isConfirmed,
  });

  factory AssignmentCompletion.fromJson(Map<String, dynamic> json) =>
      _$AssignmentCompletionFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentCompletionToJson(this);
}
