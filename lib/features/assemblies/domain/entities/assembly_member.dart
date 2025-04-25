import 'package:assembly/core/data/database/assembly_database.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly.dart';
import 'package:assembly/features/auth/domain/entities/user.dart';
import 'package:drift/drift.dart' hide JsonKey;
import 'package:json_annotation/json_annotation.dart';
part 'assembly_member.g.dart';

@UseRowClass(AssemblyMember)
class AssemblyMembers extends Table {
  TextColumn get id => text()();
  TextColumn get assemblyId => text().references(Assemblies, #id)();
  IntColumn get userId => integer().references(Users, #id)();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@JsonSerializable()
class AssemblyMember extends Insertable<AssemblyMember> {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'assembly_id')
  final String assemblyId;

  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  final AssemblyMemberRole role;

  AssemblyMember({
    required this.id,
    required this.assemblyId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.role = AssemblyMemberRole.member,
  });

  factory AssemblyMember.fromJson(Map<String, dynamic> json) =>
      _$AssemblyMemberFromJson(json);

  Map<String, dynamic> toJson() => _$AssemblyMemberToJson(this);

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return AssemblyMembersCompanion(
      id: Value(id),
      assemblyId: Value(assemblyId),
      userId: Value(userId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    ).toColumns(nullToAbsent);
  }
}

enum AssemblyMemberRole {
  @JsonValue('ADMIN')
  admin,
  @JsonValue('MEMBER')
  member,
}
