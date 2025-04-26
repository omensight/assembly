import 'package:assembly/core/data/datasources/updated_entities_record_local_data_source.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly_join_code.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly_member.dart';
import 'package:assembly/features/assemblies/domain/models/assembly_create_request.dart';
import 'package:assembly/features/assemblies/domain/models/assembly_update_request.dart';
import 'package:assembly/features/assemblies/domain/repositories/assembly_repository.dart';
import 'package:drift/drift.dart';

abstract interface class AssemblyLocalDataSource {
  Stream<List<Assembly>> getUserAssembliesStream(int userId);
  Future<void> cacheAssemblies(List<Assembly> newAssemblies);
  Stream<Assembly?> getAssemblyStream(String assemblyId);
}

abstract interface class AssemblyRemoteDataSource {
  Future<List<Assembly>> getUserAssemblies(DateTime? updatedAfter);
  Future<Assembly> postAssembly(AssemblyCreateRequest assemblyCreateRequest);
  Future<Assembly> updateAssembly(
    String assemblyId,
    AssemblyUpdateRequest assemblyUpdateRequest,
  );
  Future<AssemblyJoinCode> getAssemblyJoinCode(String assemblyId, bool refresh);
  Future<Assembly> getAssemblyByJoinCode(String joinCode);
  Future<AssemblyMember> getCurrentAssemblyMember(String assemblyId);
  Future<List<AssemblyMember>> getAssemblyMembers(String assemblyId);
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

  @override
  Future<Assembly> createAssembly(AssemblyCreateRequest assemblyCreateRequest) {
    return _assemblyRemoteDataSource.postAssembly(assemblyCreateRequest);
  }

  @override
  Future<Assembly> updateAssembly(
    String assemblyId,
    AssemblyUpdateRequest assemblyUpdateRequest,
  ) {
    return _assemblyRemoteDataSource.updateAssembly(
      assemblyId,
      assemblyUpdateRequest,
    );
  }

  @override
  Stream<Assembly?> getAssemblyStream(String assemblyId) {
    return _assemblyLocalDataSource.getAssemblyStream(assemblyId);
  }

  @override
  Future<AssemblyJoinCode> getAssemblyJoinCode(
    String assemblyId,
    bool refresh,
  ) => _assemblyRemoteDataSource.getAssemblyJoinCode(assemblyId, refresh);

  @override
  Future<Assembly> getAssemblyByJoinCode(String joinCode) =>
      _assemblyRemoteDataSource.getAssemblyByJoinCode(joinCode);

  @override
  Future<AssemblyMember> getCurrentAssemblyMember(String assemblyId) =>
      _assemblyRemoteDataSource.getCurrentAssemblyMember(assemblyId);

  @override
  Future<List<AssemblyMember>> getAssemblyMembers(String assemblyId) =>
      _assemblyRemoteDataSource.getAssemblyMembers(assemblyId);
}
