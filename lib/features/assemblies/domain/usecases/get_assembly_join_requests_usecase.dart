import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly_join_request.dart';
import 'package:assembly/features/assemblies/domain/repositories/assembly_join_request_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAssemblyJoinRequestsUsecase
    implements
        Usecase<List<AssemblyJoinRequest>, GetAssemblyJoinRequestsParams> {
  final AssemblyJoinRequestRepository _assemblyJoinRequestRepository;

  GetAssemblyJoinRequestsUsecase({
    required AssemblyJoinRequestRepository assemblyJoinRequestRepository,
  }) : _assemblyJoinRequestRepository = assemblyJoinRequestRepository;

  @override
  TaskEither<GetAssemblyJoinRequestsFailure, List<AssemblyJoinRequest>> build(
    GetAssemblyJoinRequestsParams params,
  ) {
    return TaskEither.tryCatch(
      () => _assemblyJoinRequestRepository.getAssemblyJoinRequests(
        params.assemblyId,
      ),
      (error, stackTrace) => NetworkFailure(),
    );
  }
}

class GetAssemblyJoinRequestsParams extends Params {
  final String assemblyId;

  GetAssemblyJoinRequestsParams({required this.assemblyId});
}

sealed class GetAssemblyJoinRequestsFailure extends Failure {}

class NetworkFailure extends GetAssemblyJoinRequestsFailure {}
