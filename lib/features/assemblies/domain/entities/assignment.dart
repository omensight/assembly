import 'package:json_annotation/json_annotation.dart';

part 'assignment.g.dart';

@JsonSerializable()
class Assignment {
  final String id;
  final String name;
  final String description;
  @JsonKey(name: 'assembly_id')
  final String assemblyId;
  @JsonKey(name: 'member_issuer_id')
  final String memberIssuerId;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @JsonKey(name: 'active_group_id')
  final String? activeGroupId;

  Assignment({
    required this.id,
    required this.name,
    required this.description,
    required this.assemblyId,
    required this.memberIssuerId,
    required this.createdAt,
    required this.updatedAt,
    this.activeGroupId,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) =>
      _$AssignmentFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentToJson(this);
}
