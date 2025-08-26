import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';
import 'package:assembly/features/assemblies/domain/repositories/assignment_repository.dart';
import 'package:fpdart/fpdart.dart';

class MarkAssignmentGroupCompletedParams extends Params {
  final String assemblyId;
  final String assignmentId;
  final String cycleId;
  final String assignmentGroupId;
  MarkAssignmentGroupCompletedParams({
    required this.assemblyId,
    required this.assignmentId,
    required this.cycleId,
    required this.assignmentGroupId,
  });
}

sealed class MarkAssignmentGroupCompletedFailure extends Failure {}

class MarkAssignmentGroupCompletedNetworkFailure
    extends MarkAssignmentGroupCompletedFailure {}

class MarkAssignmentGroupCompletedUsecase
    extends Usecase<void, MarkAssignmentGroupCompletedParams> {
  final AssignmentRepository _assignmentRepository;

  MarkAssignmentGroupCompletedUsecase({
    required AssignmentRepository repository,
  }) : _assignmentRepository = repository;

  @override
  TaskEither<MarkAssignmentGroupCompletedFailure, void> build(
    MarkAssignmentGroupCompletedParams params,
  ) {
    return TaskEither.tryCatch(
      () => _assignmentRepository.markAssignmentGroupAsCompleted(
        assemblyId: params.assemblyId,
        assignmentId: params.assignmentId,
        assignmentGroupId: params.assignmentGroupId,
        cycleId: params.cycleId,
      ),
      (error, stackTrace) => MarkAssignmentGroupCompletedNetworkFailure(),
    );
  }
}
