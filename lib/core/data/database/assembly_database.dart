import 'package:assembly/core/data/entities/updated_entities_records.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly_member.dart';
import 'package:assembly/features/auth/domain/entities/user.dart';
import 'package:drift/drift.dart';
import 'package:assembly/features/auth/domain/entities/server_token.dart';
part 'assembly_database.g.dart';

@DriftDatabase(
  tables: [
    ServerTokens,
    Users,
    Assemblies,
    AssemblyMembers,
    UpdatedEntitiesRecords,
  ],
)
class AssemblyDatabase extends _$AssemblyDatabase {
  AssemblyDatabase(super.executor);

  @override
  int get schemaVersion => 1;
}
