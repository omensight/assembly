import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly.dart';
import 'package:assembly/features/assemblies/domain/models/assembly_create_request.dart';
import 'package:assembly/features/assemblies/domain/repositories/assembly_repository.dart';
import 'package:fpdart/fpdart.dart';

class CreateAssemblyUsecase implements Usecase<void, CreateAssemblyParams> {
  final AssemblyRepository _assemblyRepository;

  CreateAssemblyUsecase({required AssemblyRepository assemblyRepository})
    : _assemblyRepository = assemblyRepository;

  @override
  TaskEither<CreateAssemblyFailure, Assembly> build(
    CreateAssemblyParams params,
  ) {
    return TaskEither.tryCatch(
      () => _assemblyRepository.createAssembly(
        AssemblyCreateRequest(name: params.name, address: params.address),
      ),
      (error, stackTrace) => NetworkFailure(),
    );
  }
}

class CreateAssemblyParams extends Params {
  final String name;
  final String address;

  CreateAssemblyParams({required this.name, required this.address});
}

sealed class CreateAssemblyFailure extends Failure {}

class NetworkFailure extends CreateAssemblyFailure {}
