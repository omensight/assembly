import 'package:assembly/core/providers/database_providers.dart';
import 'package:assembly/features/assemblies/data/data_sources/assembly_local_data_source_impl.dart';
import 'package:assembly/features/assemblies/data/repositories/assembly_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_source_providers.g.dart';

@riverpod
AssemblyLocalDataSource assemblyLocalDataSource(Ref ref) {
  return AssemblyLocalDataSourceImpl(ref.watch(assemblyDatabaseProvider));
}
