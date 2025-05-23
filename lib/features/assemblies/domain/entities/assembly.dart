import 'package:assembly/core/data/database/assembly_database.dart';
import 'package:assembly/features/auth/domain/entities/user.dart';
import 'package:drift/drift.dart' hide JsonKey;
import 'package:json_annotation/json_annotation.dart';
part 'assembly.g.dart';

@UseRowClass(Assembly)
class Assemblies extends Table {
  TextColumn get id => text()();
  IntColumn get userFounderId => integer().references(Users, #id)();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get name => text()();
  TextColumn get address => text()();
  BoolColumn get isActive => boolean()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@JsonSerializable()
class Assembly extends Insertable<Assembly> {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'user_founder_id')
  final int userFounderId;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'address')
  final String address;

  @JsonKey(name: 'is_active')
  final bool isActive;

  Assembly({
    required this.id,
    required this.userFounderId,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.address,
    required this.isActive,
  });

  factory Assembly.fromJson(Map<String, dynamic> json) =>
      _$AssemblyFromJson(json);

  Map<String, dynamic> toJson() => _$AssemblyToJson(this);

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return AssembliesCompanion(
      id: Value(id),
      userFounderId: Value(userFounderId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      name: Value(name),
      address: Value(address),
      isActive: Value(isActive),
    ).toColumns(nullToAbsent);
  }
}
