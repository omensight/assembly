import 'package:assembly/features/assemblies/domain/usecases/get_assemblies_list_stream_usecase.dart';
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
