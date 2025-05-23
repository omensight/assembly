import 'package:assembly/core/data/database/assembly_database.dart';
import 'package:assembly/features/assemblies/data/repositories/assembly_repository_impl.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly.dart';
import 'package:drift/drift.dart';
part 'assembly_local_data_source_impl.g.dart';

@DriftAccessor(tables: [Assemblies])
class AssemblyLocalDataSourceImpl extends DatabaseAccessor<AssemblyDatabase>
    with _$AssemblyLocalDataSourceImplMixin
    implements AssemblyLocalDataSource {
  AssemblyLocalDataSourceImpl(super.attachedDatabase);

  @override
  Stream<List<Assembly>> getUserAssembliesStream(int userId) async* {
    yield* (select(assemblies)).watch();
  }

  @override
  Future<void> cacheAssemblies(List<Assembly> newAssemblies) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(assemblies, newAssemblies);
    });
  }

  @override
  Stream<Assembly?> getAssemblyStream(String assemblyId) {
    return (select(assemblies)
      ..where((tbl) => tbl.id.equals(assemblyId))).watchSingleOrNull();
  }
}
