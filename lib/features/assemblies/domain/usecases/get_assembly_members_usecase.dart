import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly_member.dart';
import 'package:assembly/features/assemblies/domain/repositories/assembly_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAssemblyMembersUsecase
    implements Usecase<List<AssemblyMember>, GetAssemblyMembersParams> {
  final AssemblyRepository _assemblyRepository;

  GetAssemblyMembersUsecase({required AssemblyRepository assemblyRepository})
    : _assemblyRepository = assemblyRepository;

  @override
  TaskEither<GetAssemblyMembersFailure, List<AssemblyMember>> build(
    GetAssemblyMembersParams params,
  ) {
    return TaskEither.tryCatch(
      () => _assemblyRepository.getAssemblyMembers(params.assemblyId),
      (error, stackTrace) => NetworkFailure(),
    );
  }
}

class GetAssemblyMembersParams extends Params {
  final String assemblyId;

  GetAssemblyMembersParams({required this.assemblyId});
}

sealed class GetAssemblyMembersFailure extends Failure {}

class NetworkFailure extends GetAssemblyMembersFailure {}
