import 'package:assembly/features/assemblies/domain/usecases/create_assembly_usecase.dart';
import 'package:assembly/features/assemblies/domain/usecases/fetch_user_assemblies_usecase.dart';
import 'package:assembly/features/assemblies/domain/usecases/get_assemblies_list_stream_usecase.dart';
import 'package:assembly/features/assemblies/domain/usecases/get_assembly_by_join_code_usecase.dart';
import 'package:assembly/features/assemblies/domain/usecases/get_assembly_join_code_usecase.dart';
import 'package:assembly/features/assemblies/domain/usecases/get_assembly_stream_usecase.dart';
import 'package:assembly/features/assemblies/presentation/providers/repository_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'usecase_providers.g.dart';

@riverpod
GetAssembliesListStreamUsecase getAssembliesListStreamUsecase(Ref ref) {
  return GetAssembliesListStreamUsecase(
    assemblyRepository: ref.watch(assemblyRepositoryProvider),
  );
}

@riverpod
FetchUserAssembliesUsecase fetchUserAssembliesUsecase(Ref ref) {
  return FetchUserAssembliesUsecase(
    assemblyRepository: ref.watch(assemblyRepositoryProvider),
  );
}

@riverpod
CreateAssemblyUsecase createAssemblyUsecase(Ref ref) {
  return CreateAssemblyUsecase(
    assemblyRepository: ref.watch(assemblyRepositoryProvider),
  );
}

@riverpod
GetAssemblyStreamUsecase getAssemblyStreamUsecase(Ref ref) {
  return GetAssemblyStreamUsecase(
    assemblyRepository: ref.watch(assemblyRepositoryProvider),
  );
}

@riverpod
GetAssemblyJoinCodeUsecase getAssemblyJoinCodeUsecase(Ref ref) {
  return GetAssemblyJoinCodeUsecase(
    assemblyRepository: ref.watch(assemblyRepositoryProvider),
  );
}

@riverpod
GetAssemblyByJoinCodeUsecase getAssemblyByJoinCodeUsecase(Ref ref) {
  return GetAssemblyByJoinCodeUsecase(
    assemblyRepository: ref.watch(assemblyRepositoryProvider),
  );
}
