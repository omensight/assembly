import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';
import 'package:assembly/features/assemblies/domain/repositories/assembly_join_request_repository.dart';
import 'package:fpdart/fpdart.dart';

class RejectJoinRequestUsecase
    implements Usecase<void, RejectJoinRequestParams> {
  final AssemblyJoinRequestRepository _assemblyJoinRequestRepository;

  RejectJoinRequestUsecase({
    required AssemblyJoinRequestRepository assemblyJoinRequestRepository,
  }) : _assemblyJoinRequestRepository = assemblyJoinRequestRepository;

  @override
  TaskEither<RejectJoinRequestFailure, void> build(
    RejectJoinRequestParams params,
  ) {
    return TaskEither.tryCatch(
      () => _assemblyJoinRequestRepository.rejectJoinRequest(
        params.assemblyId,
        params.joinRequestId,
      ),
      (error, stackTrace) => NetworkFailure(),
    );
  }
}

class RejectJoinRequestParams extends Params {
  final String assemblyId;
  final String joinRequestId;

  RejectJoinRequestParams({
    required this.assemblyId,
    required this.joinRequestId,
  });
}

sealed class RejectJoinRequestFailure extends Failure {}

class NetworkFailure extends RejectJoinRequestFailure {}
