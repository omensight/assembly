import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment.dart';
import 'package:assembly/features/assemblies/domain/repositories/assignment_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAssignmentParams extends Params {
  final String assemblyId;
  final String assignmentId;

  GetAssignmentParams({required this.assemblyId, required this.assignmentId});
}

sealed class GetAssignmentFailure extends Failure {}

class GetAssignmentNetworkFailure extends GetAssignmentFailure {}

class GetAssignmentUsecase extends Usecase<Assignment, GetAssignmentParams> {
  final AssignmentRepository _assignmentRepository;

  GetAssignmentUsecase({required AssignmentRepository assignmentRepository})
    : _assignmentRepository = assignmentRepository;

  @override
  TaskEither<GetAssignmentFailure, Assignment> build(
    GetAssignmentParams params,
  ) {
    return TaskEither.tryCatch(
      () => _assignmentRepository.getAssignment(
        params.assemblyId,
        params.assignmentId,
      ),
      (error, stackTrace) => GetAssignmentNetworkFailure(),
    );
  }
}
