import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment_group.dart';
import 'package:assembly/features/assemblies/domain/repositories/assignment_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAssignmentsGroupsUsecase
    extends Usecase<List<AssignmentGroup>, GetAssignmentsGroupsParams> {
  final AssignmentRepository _assignmentRepository;
  GetAssignmentsGroupsUsecase({
    required AssignmentRepository assignmentRemoteDataSource,
  }) : _assignmentRepository = assignmentRemoteDataSource;

  @override
  TaskEither<GetAssignmentGroupsFailure, List<AssignmentGroup>> build(
    GetAssignmentsGroupsParams params,
  ) {
    return TaskEither.tryCatch(
      () => _assignmentRepository.getAssignmentGroups(
        params.assemblyId,
        params.assignmentId,
        params.cycleId,
      ),
      (object, stackTrace) => GetAssignmentGroupsNetworkFailure(),
    );
  }
}

class GetAssignmentsGroupsParams extends Params {
  final String assignmentId;
  final String assemblyId;
  final String cycleId;

  GetAssignmentsGroupsParams({
    required this.assignmentId,
    required this.assemblyId,
    required this.cycleId,
  });
}

sealed class GetAssignmentGroupsFailure extends Failure {}

class GetAssignmentGroupsNetworkFailure extends GetAssignmentGroupsFailure {}
