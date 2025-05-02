import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment_settings.dart';
import 'package:assembly/features/assemblies/domain/repositories/assignment_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

sealed class GetAssignmentSettingsFailure extends Failure {}

class AssignmentSettingsNetworkFailure extends GetAssignmentSettingsFailure {}

class AssignmentSettingsNotFoundFailure extends GetAssignmentSettingsFailure {}

class GetAssignmentSettingsParams extends Params {
  final String assemblyId;
  final String assignmentId;

  GetAssignmentSettingsParams({
    required this.assemblyId,
    required this.assignmentId,
  });
}

class GetAssignmentSettingsUsecase
    extends Usecase<AssignmentSettings?, GetAssignmentSettingsParams> {
  final AssignmentRepository _repository;

  GetAssignmentSettingsUsecase({required AssignmentRepository repository})
    : _repository = repository;

  @override
  TaskEither<GetAssignmentSettingsFailure, AssignmentSettings> build(
    GetAssignmentSettingsParams params,
  ) {
    return TaskEither.tryCatch(
      () {
        return _repository.getAssignmentSettings(
          params.assemblyId,
          params.assignmentId,
        );
      },
      (error, stackTrace) {
        if (error is DioException) {
          if (error.response?.statusCode == 404) {
            return AssignmentSettingsNotFoundFailure();
          }
        }
        return AssignmentSettingsNetworkFailure();
      },
    );
  }
}
