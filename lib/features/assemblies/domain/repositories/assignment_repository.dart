import 'package:assembly/features/assemblies/domain/entities/assignment.dart';
import 'package:assembly/features/assemblies/domain/models/assignment_create_request.dart';

abstract class AssignmentRepository {
  Future<Assignment> createAssignment({
    required String assemblyId,
    required AssignmentCreateRequest request,
  });
}
