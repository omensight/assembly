import 'package:json_annotation/json_annotation.dart';

part 'assignment_group.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AssignmentGroup {
  final String id;
  final String assignment;
  final DateTime createdAt;
  final DateTime updatedAt;

  AssignmentGroup({
    required this.id,
    required this.assignment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AssignmentGroup.fromJson(Map<String, dynamic> json) =>
      _$AssignmentGroupFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentGroupToJson(this);
}
