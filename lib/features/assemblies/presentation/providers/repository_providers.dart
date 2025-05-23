import 'package:assembly/core/providers/data_source_providers.dart';
import 'package:assembly/features/assemblies/data/repositories/assignment_repository_impl.dart';
import 'package:assembly/features/assemblies/data/repositories/assembly_join_request_repository_impl.dart';
import 'package:assembly/features/assemblies/data/repositories/assembly_repository_impl.dart';
import 'package:assembly/features/assemblies/domain/repositories/assignment_repository.dart';
import 'package:assembly/features/assemblies/domain/repositories/assembly_join_request_repository.dart';
import 'package:assembly/features/assemblies/domain/repositories/assembly_repository.dart';
import 'package:assembly/features/assemblies/presentation/providers/data_source_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_providers.g.dart';

@riverpod
AssemblyRepository assemblyRepository(Ref ref) {
  return AssemblyRepositoryImpl(
    assemblyLocalDataSource: ref.watch(assemblyLocalDataSourceProvider),
    assemblyRemoteDataSource: ref.watch(assemblyRemoteDataSourceProvider),
    updatedEntitiesRecordLocalDataSource: ref.watch(
      updatedEntitiesRecordLocalDataSourceProvider,
    ),
  );
}

@riverpod
AssemblyJoinRequestRepository assemblyJoinRequestRepository(Ref ref) {
  return AssemblyJoinRequestRepositoryImpl(
    assembleJoinRequestRemoteDataSource: ref.watch(
      assemblyJoinRequestRemoteDataSourceProvider,
    ),
  );
}

@riverpod
AssignmentRepository assignmentRepository(Ref ref) {
  return AssignmentRepositoryImpl(
    ref.watch(assignmentRemoteDataSourceProvider),
  );
}
