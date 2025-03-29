import 'package:assembly/features/assemblies/data/repositories/assembly_repository_impl.dart';
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
  );
}
