import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment.dart';
import 'package:assembly/features/assemblies/domain/repositories/assignment_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAssemblyAssignmentsListUsecase
    extends Usecase<List<Assignment>, GetAssemblyAssignmentsListParams> {
  final AssignmentRepository _assignmentRepository;

  GetAssemblyAssignmentsListUsecase({
    required AssignmentRepository assignmentRepository,
  }) : _assignmentRepository = assignmentRepository;

  @override
  TaskEither<GetAssemblyAssignmentsFailure, List<Assignment>> build(
    GetAssemblyAssignmentsListParams params,
  ) {
    return TaskEither.tryCatch(
      () => _assignmentRepository.getAssemblyAssignments(params.assemblyId),
      (object, stackTrace) => GetAssemblyAssignmentsNetworkFailure(),
    );
  }
}

class GetAssemblyAssignmentsListParams extends Params {
  final String assemblyId;

  GetAssemblyAssignmentsListParams({required this.assemblyId});
}

sealed class GetAssemblyAssignmentsFailure extends Failure {}

class GetAssemblyAssignmentsNetworkFailure
    extends GetAssemblyAssignmentsFailure {}
