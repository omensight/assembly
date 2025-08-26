import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';
import 'package:assembly/features/assemblies/domain/repositories/assignment_repository.dart';
import 'package:fpdart/fpdart.dart';

class ConfirmAssignmentGroupCompletionParams extends Params {
  final String assemblyId;
  final String assignmentId;
  final String cycleId;
  final String assignmentGroupId;
  ConfirmAssignmentGroupCompletionParams({
    required this.assemblyId,
    required this.assignmentId,
    required this.cycleId,
    required this.assignmentGroupId,
  });
}

sealed class ConfirmAssignmentGroupCompletionFailure extends Failure {}

class ConfirmAssignmentGroupCompletionNetworkFailure
    extends ConfirmAssignmentGroupCompletionFailure {}

class ConfirmAssignmentGroupCompletionUsecase
    extends Usecase<void, ConfirmAssignmentGroupCompletionParams> {
  final AssignmentRepository _assignmentRepository;

  ConfirmAssignmentGroupCompletionUsecase({
    required AssignmentRepository repository,
  }) : _assignmentRepository = repository;

  @override
  TaskEither<ConfirmAssignmentGroupCompletionFailure, void> build(
    ConfirmAssignmentGroupCompletionParams params,
  ) {
    return TaskEither.tryCatch(() async {
      await _assignmentRepository.confirmAssignmentGroupCompletion(
        assemblyId: params.assemblyId,
        assignmentId: params.assignmentId,
        assignmentGroupId: params.assignmentGroupId,
        cycleId: params.cycleId,
      );
    }, (error, stackTrace) => ConfirmAssignmentGroupCompletionNetworkFailure());
  }
}
