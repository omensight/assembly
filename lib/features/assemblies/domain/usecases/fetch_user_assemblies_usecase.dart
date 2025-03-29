import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';
import 'package:assembly/features/assemblies/domain/repositories/assembly_repository.dart';
import 'package:fpdart/fpdart.dart';

class FetchUserAssembliesUsecase implements Usecase<void, NoParams> {
  final AssemblyRepository _assemblyRepository;

  FetchUserAssembliesUsecase({required AssemblyRepository assemblyRepository})
    : _assemblyRepository = assemblyRepository;

  @override
  TaskEither<FetchUserAssembliesFailure, void> build(NoParams params) {
    return TaskEither.tryCatch(
      () => _assemblyRepository.fetchUserAssemblies(),
      (error, stackTrace) => NetworkFailure(),
    );
  }
}

sealed class FetchUserAssembliesFailure extends Failure {}

class NetworkFailure extends FetchUserAssembliesFailure {}
