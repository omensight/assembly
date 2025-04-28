import 'package:assembly/core/providers/client_providers.dart';
import 'package:assembly/core/providers/database_providers.dart';
import 'package:assembly/features/assemblies/data/data_sources/assignment_remote_data_source_impl.dart';
import 'package:assembly/features/assemblies/data/data_sources/assembly_join_request_remote_data_source_impl.dart';
import 'package:assembly/features/assemblies/data/data_sources/assembly_local_data_source_impl.dart';
import 'package:assembly/features/assemblies/data/data_sources/assembly_remote_data_source_impl.dart';
import 'package:assembly/features/assemblies/data/repositories/assembly_join_request_repository_impl.dart';
import 'package:assembly/features/assemblies/data/repositories/assembly_repository_impl.dart';
import 'package:assembly/features/assemblies/data/repositories/assignment_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_source_providers.g.dart';

@riverpod
AssemblyLocalDataSource assemblyLocalDataSource(Ref ref) {
  return AssemblyLocalDataSourceImpl(ref.watch(assemblyDatabaseProvider));
}

@riverpod
AssemblyRemoteDataSource assemblyRemoteDataSource(Ref ref) {
  return AssemblyRemoteDataSourceImpl(
    ref.watch(mainDioProvider),
    baseUrl: ref.watch(baseUrlProvider),
  );
}

@riverpod
AssemblyJoinRequestRemoteDataSource assemblyJoinRequestRemoteDataSource(
  Ref ref,
) {
  return AssemblyJoinRequestRemoteDataSourceImpl(
    ref.watch(mainDioProvider),
    baseUrl: ref.watch(baseUrlProvider),
  );
}

@riverpod
AssignmentRemoteDataSource assignmentRemoteDataSource(Ref ref) {
  return AssignmentRemoteDataSourceImpl(
    ref.watch(mainDioProvider),
    baseUrl: ref.watch(baseUrlProvider),
  );
}
