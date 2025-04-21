import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';
import 'package:assembly/features/assemblies/domain/repositories/assembly_join_request_repository.dart';
import 'package:fpdart/fpdart.dart';

class AcceptJoinRequestUsecase
    implements Usecase<void, AcceptJoinRequestParams> {
  final AssemblyJoinRequestRepository _assemblyJoinRequestRepository;

  AcceptJoinRequestUsecase({
    required AssemblyJoinRequestRepository assemblyJoinRequestRepository,
  }) : _assemblyJoinRequestRepository = assemblyJoinRequestRepository;

  @override
  TaskEither<AcceptJoinRequestFailure, void> build(
    AcceptJoinRequestParams params,
  ) {
    return TaskEither.tryCatch(
      () => _assemblyJoinRequestRepository.acceptJoinRequest(
        params.assemblyId,
        params.joinRequestId,
      ),
      (error, stackTrace) => NetworkFailure(),
    );
  }
}

class AcceptJoinRequestParams extends Params {
  final String assemblyId;
  final String joinRequestId;

  AcceptJoinRequestParams({
    required this.assemblyId,
    required this.joinRequestId,
  });
}

sealed class AcceptJoinRequestFailure extends Failure {}

class NetworkFailure extends AcceptJoinRequestFailure {}
