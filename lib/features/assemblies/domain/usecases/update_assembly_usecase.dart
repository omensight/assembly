import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly.dart';
import 'package:assembly/features/assemblies/domain/models/assembly_update_request.dart';
import 'package:assembly/features/assemblies/domain/repositories/assembly_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateAssemblyUsecase implements Usecase<Assembly, UpdateAssemblyParams> {
  final AssemblyRepository _assemblyRepository;

  const UpdateAssemblyUsecase({required AssemblyRepository assemblyRepository})
    : _assemblyRepository = assemblyRepository;

  @override
  TaskEither<UpdateAssemblyFailure, Assembly> build(
    UpdateAssemblyParams params,
  ) {
    return TaskEither.tryCatch(
      () => _assemblyRepository.updateAssembly(
        params.assemblyId,
        params.assemblyUpdateRequest,
      ),
      (error, stackTrace) => NetworkFailure(),
    );
  }
}

class UpdateAssemblyParams extends Params {
  final String assemblyId;
  final AssemblyUpdateRequest assemblyUpdateRequest;

  UpdateAssemblyParams({
    required this.assemblyId,
    required this.assemblyUpdateRequest,
  });
}

sealed class UpdateAssemblyFailure extends Failure {}

class NetworkFailure extends UpdateAssemblyFailure {}
