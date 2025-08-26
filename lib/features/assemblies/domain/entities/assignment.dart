import 'package:assembly/features/assemblies/domain/entities/assignment_cycle.dart';
import 'package:json_annotation/json_annotation.dart';

part 'assignment.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Assignment {
  final String id;
  final String name;
  final String description;
  final String assemblyId;
  final String memberIssuerId;
  final DateTime createdAt;
  final DateTime updatedAt;

  final AssignmentCycle? activeAssignmentCycle;

  Assignment({
    required this.id,
    required this.name,
    required this.description,
    required this.assemblyId,
    required this.memberIssuerId,
    required this.createdAt,
    required this.updatedAt,
    this.activeAssignmentCycle,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) =>
      _$AssignmentFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentToJson(this);
}
