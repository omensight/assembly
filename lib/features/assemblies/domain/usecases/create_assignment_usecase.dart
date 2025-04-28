import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment.dart';
import 'package:assembly/features/assemblies/domain/models/assignment_create_request.dart';
import 'package:assembly/features/assemblies/domain/repositories/assignment_repository.dart';
import 'package:fpdart/fpdart.dart';

sealed class CreateAssignmentFailure extends Failure {}

class NetworkFailure extends CreateAssignmentFailure {}

class CreateAssignmentParams extends Params {
  final String assemblyId;
  final String name;
  final String description;
  final int rotationDuration;

  CreateAssignmentParams({
    required this.assemblyId,
    required this.name,
    required this.description,
    required this.rotationDuration,
  });
}

class CreateAssignmentUsecase
    extends Usecase<Assignment, CreateAssignmentParams> {
  final AssignmentRepository _repository;

  CreateAssignmentUsecase({required AssignmentRepository repository})
    : _repository = repository;

  @override
  TaskEither<CreateAssignmentFailure, Assignment> build(
    CreateAssignmentParams params,
  ) {
    return TaskEither.tryCatch(() {
      final request = AssignmentCreateRequest(
        name: params.name,
        description: params.description,
        rotationDuration: params.rotationDuration,
      );

      return _repository.createAssignment(
        assemblyId: params.assemblyId,
        request: request,
      );
    }, (error, stackTrace) => NetworkFailure());
  }
}
