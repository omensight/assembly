import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly_member.dart';
import 'package:assembly/features/assemblies/domain/repositories/assembly_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCurrentAssemblyMemberUseCase
    implements Usecase<AssemblyMember, GetCurrentAssemblyMemberParams> {
  final AssemblyRepository _assemblyRepository;

  const GetCurrentAssemblyMemberUseCase({
    required AssemblyRepository assemblyRepository,
  }) : _assemblyRepository = assemblyRepository;

  @override
  TaskEither<AssemblyMemberFailure, AssemblyMember> build(
    GetCurrentAssemblyMemberParams params,
  ) {
    return TaskEither.tryCatch(
      () => _assemblyRepository.getCurrentAssemblyMember(params.assemblyId),
      (error, stackTrace) => RetrieveFailure(),
    );
  }
}

class GetCurrentAssemblyMemberParams extends Params {
  final String assemblyId;

  GetCurrentAssemblyMemberParams({required this.assemblyId});
}

sealed class AssemblyMemberFailure extends Failure {}

class RetrieveFailure extends AssemblyMemberFailure {}
