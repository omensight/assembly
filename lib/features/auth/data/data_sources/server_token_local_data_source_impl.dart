import 'package:assembly/core/data/database/assembly_database.dart';
import 'package:assembly/features/auth/data/repositories/server_token_repository_impl.dart';
import 'package:assembly/features/auth/domain/entities/server_token.dart';
import 'package:drift/drift.dart';
part 'server_token_local_data_source_impl.g.dart';

@DriftAccessor(tables: [ServerTokens])
class ServerTokenLocalDataSourceImpl extends DatabaseAccessor<AssemblyDatabase>
    with _$ServerTokenLocalDataSourceImplMixin
    implements ServerTokenLocalDataSource {
  ServerTokenLocalDataSourceImpl(super.attachedDatabase);

  @override
  Future<void> save(ServerToken serverToken) async {
    await into(serverTokens).insertOnConflictUpdate(serverToken);
  }

  @override
  Stream<ServerToken?> getServerTokenStream() {
    return (select(serverTokens)
      ..where((tbl) => tbl.id.equals(uniqueId))).watchSingleOrNull();
  }
}
