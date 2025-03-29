import 'package:assembly/core/data/datasources/updated_entities_record_local_data_source.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly.dart';
import 'package:assembly/features/assemblies/domain/repositories/assembly_repository.dart';
import 'package:drift/drift.dart';

abstract interface class AssemblyLocalDataSource {
  Stream<List<Assembly>> getUserAssembliesStream(int userId);
  Future<void> cacheAssemblies(List<Assembly> newAssemblies);
}

abstract interface class AssemblyRemoteDataSource {
  Future<List<Assembly>> getUserAssemblies(DateTime? updatedAfter);
}

class AssemblyRepositoryImpl implements AssemblyRepository {
  final AssemblyLocalDataSource _assemblyLocalDataSource;
  final AssemblyRemoteDataSource _assemblyRemoteDataSource;
  final UpdatedEntitiesRecordLocalDataSource
  _updatedEntitiesRecordLocalDataSource;

  AssemblyRepositoryImpl({
    required AssemblyLocalDataSource assemblyLocalDataSource,
    required AssemblyRemoteDataSource assemblyRemoteDataSource,
    required UpdatedEntitiesRecordLocalDataSource
    updatedEntitiesRecordLocalDataSource,
  }) : _updatedEntitiesRecordLocalDataSource =
           updatedEntitiesRecordLocalDataSource,
       _assemblyLocalDataSource = assemblyLocalDataSource,
       _assemblyRemoteDataSource = assemblyRemoteDataSource;

  @override
  Stream<List<Assembly>> getUserAssembliesStream(int userId) =>
      _assemblyLocalDataSource.getUserAssembliesStream(userId);

  @override
  Future<void> fetchUserAssemblies() async {
    final updatedEntityRecord =
        await _updatedEntitiesRecordLocalDataSource.getUpdatedEntityRecord();
    DateTime? lastTimeAssembliesWhereUpdated = updatedEntityRecord.assemblies;
    final assemblies = await _assemblyRemoteDataSource.getUserAssemblies(
      lastTimeAssembliesWhereUpdated?.toUtc(),
    );
    lastTimeAssembliesWhereUpdated = DateTime.now().toUtc();
    final updatedRecord = updatedEntityRecord.copyWith(
      assemblies: Value(lastTimeAssembliesWhereUpdated.toUtc()),
    );

    await _assemblyLocalDataSource.cacheAssemblies(assemblies);

    _updatedEntitiesRecordLocalDataSource.updateRecord(updatedRecord);
  }
}
