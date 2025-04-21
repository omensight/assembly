import 'package:assembly/core/data/database/assembly_database.dart';
import 'package:drift/drift.dart' hide JsonKey;
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@UseRowClass(User)
class Users extends Table {
  IntColumn get id => integer()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get username => text()();
  BoolColumn get isTheAuthenticatedUser =>
      boolean().clientDefault(() => false)();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@JsonSerializable()
class User extends Insertable<User> {
  final int id;

  @JsonKey(name: 'first_name')
  final String firstName;

  @JsonKey(name: 'last_name')
  final String lastName;

  @JsonKey(name: 'username')
  final String username;

  final bool isTheAuthenticatedUser;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    this.isTheAuthenticatedUser = false,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      username: Value(username),
    ).toColumns(nullToAbsent);
  }

  String get fullName {
    return '$firstName $lastName';
  }
}
