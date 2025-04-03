import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly_join_request.dart';
import 'package:assembly/features/assemblies/domain/models/assembly_join_request_body_request.dart';
import 'package:assembly/features/assemblies/domain/repositories/assembly_join_request_repository.dart';
import 'package:fpdart/fpdart.dart';

class CreateAssemblyJoinRequestUsecase
    implements Usecase<void, CreateAssemblyJoinRequestParams> {
  final AssemblyJoinRequestRepository _assemblyJoinRequestRepository;

  CreateAssemblyJoinRequestUsecase({
    required AssemblyJoinRequestRepository assemblyJoinRequestRepository,
  }) : _assemblyJoinRequestRepository = assemblyJoinRequestRepository;

  @override
  TaskEither<CreateAssemblyJoinRequestFailure, AssemblyJoinRequest> build(
    CreateAssemblyJoinRequestParams params,
  ) {
    return TaskEither.tryCatch(
      () => _assemblyJoinRequestRepository.postAssemblyJoinRequest(
        params.assemblyId,
        AssemblyJoinRequestBodyRequest(joinCode: params.joinRequestCode),
      ),
      (error, stackTrace) => NetworkFailure(),
    );
  }
}

class CreateAssemblyJoinRequestParams extends Params {
  final String assemblyId;
  final String joinRequestCode;

  CreateAssemblyJoinRequestParams({
    required this.assemblyId,
    required this.joinRequestCode,
  });
}

sealed class CreateAssemblyJoinRequestFailure extends Failure {}

class NetworkFailure extends CreateAssemblyJoinRequestFailure {}
