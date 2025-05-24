import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment_settings.dart';
import 'package:assembly/features/assemblies/domain/models/assignment_settings_create_request.dart';
import 'package:assembly/features/assemblies/domain/repositories/assignment_repository.dart';
import 'package:fpdart/fpdart.dart';

sealed class CreateAssignmentSettingsFailure extends Failure {}

class AssignmentSettingsNetworkFailure
    extends CreateAssignmentSettingsFailure {}

class CreateAssignmentSettingsParams extends Params {
  final String assemblyId;
  final String assignmentId;
  final bool isRepeatingTheEntireCycle;
  final int turnDurationInDays;
  final DateTime startDateAndTime;
  final int groupSize;

  CreateAssignmentSettingsParams({
    required this.assemblyId,
    required this.assignmentId,
    required this.isRepeatingTheEntireCycle,
    required this.turnDurationInDays,
    required this.startDateAndTime,
    required this.groupSize,
  });
}

class CreateAssignmentSettingsUsecase
    extends Usecase<AssignmentSettings, CreateAssignmentSettingsParams> {
  final AssignmentRepository _repository;

  CreateAssignmentSettingsUsecase({required AssignmentRepository repository})
    : _repository = repository;

  @override
  TaskEither<CreateAssignmentSettingsFailure, AssignmentSettings> build(
    CreateAssignmentSettingsParams params,
  ) {
    return TaskEither.tryCatch(() {
      final request = AssignmentSettingsCreateRequest(
        isRepeatingTheEntireCycle: params.isRepeatingTheEntireCycle,
        turnDurationInDays: params.turnDurationInDays,
        startDateAndTime: params.startDateAndTime,
        groupSize: params.groupSize,
        createGroups: true,
      );

      return _repository.createAssignmentSettings(
        assemblyId: params.assemblyId,
        assignmentId: params.assignmentId,
        request: request,
      );
    }, (error, stackTrace) => AssignmentSettingsNetworkFailure());
  }
}
