import 'package:drift/drift.dart';
import 'package:assembly/features/auth/domain/entities/server_token.dart';
part 'assembly_database.g.dart';

@DriftDatabase(tables: [ServerTokens])
class AssemblyDatabase extends _$AssemblyDatabase {
  AssemblyDatabase(super.executor);

  @override
  int get schemaVersion => 1;
}
