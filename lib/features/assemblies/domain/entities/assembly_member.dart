import 'package:assembly/features/auth/domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'assembly_member.g.dart';

@JsonSerializable()
class AssemblyMember {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'assembly_id')
  final String assemblyId;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  final User user;

  final AssemblyMemberRole role;

  AssemblyMember({
    required this.id,
    required this.assemblyId,
    required this.createdAt,
    required this.updatedAt,
    this.role = AssemblyMemberRole.member,
    required this.user,
  });

  factory AssemblyMember.fromJson(Map<String, dynamic> json) =>
      _$AssemblyMemberFromJson(json);

  Map<String, dynamic> toJson() => _$AssemblyMemberToJson(this);
}

enum AssemblyMemberRole {
  @JsonValue('ADMIN')
  admin,
  @JsonValue('MEMBER')
  member,
}
