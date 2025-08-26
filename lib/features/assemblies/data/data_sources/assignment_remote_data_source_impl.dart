import 'package:assembly/features/assemblies/data/repositories/assignment_repository_impl.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment_group.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment_settings.dart';
import 'package:assembly/features/assemblies/domain/models/assignment_create_request.dart';
import 'package:assembly/features/assemblies/domain/models/assignment_settings_create_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'assignment_remote_data_source_impl.g.dart';

@RestApi()
abstract class AssignmentRemoteDataSourceImpl
    implements AssignmentRemoteDataSource {
  factory AssignmentRemoteDataSourceImpl(
    Dio dio, {
    required String baseUrl,
    ParseErrorLogger errorLogger,
  }) = _AssignmentRemoteDataSourceImpl;

  @POST('/assemblies/{assemblyId}/assignments/')
  @override
  Future<Assignment> createAssignment(
    @Path('assemblyId') String assemblyId,
    @Body() AssignmentCreateRequest request,
  );

  @POST('/assemblies/{assemblyId}/assignments/{assignmentId}/settings/')
  @override
  Future<AssignmentSettings> createAssignmentSettings(
    @Path('assemblyId') String assemblyId,
    @Path('assignmentId') String assignmentId,
    @Body() AssignmentSettingsCreateRequest request,
  );

  @GET(
    '/assemblies/{assemblyId}/assignments/{assignmentId}/cycles/{cycleId}/assignment-groups/',
  )
  @override
  Future<List<AssignmentGroup>> getAssignmentGroups(
    @Path('assemblyId') String assemblyId,
    @Path('assignmentId') String assignmentId,
    @Path('cycleId') String cycleId,
  );

  @GET('/assemblies/{assemblyId}/assignments/{assignmentId}/')
  @override
  Future<Assignment> getAssignment(
    @Path('assemblyId') String assemblyId,
    @Path('assignmentId') String assignmentId,
  );

  @GET(
    '/assemblies/{assemblyId}/assignments/{assignmentId}/settings/{assignmentId}',
  )
  @override
  Future<AssignmentSettings> getAssignmentSettings(
    @Path('assemblyId') String assemblyId,
    @Path('assignmentId') String assignmentId,
  );

  @GET('/assemblies/{assemblyId}/assignments/')
  @override
  Future<List<Assignment>> getAssemblyAssignments(
    @Path('assemblyId') String assemblyId,
  );

  @POST(
    '/assemblies/{assemblyId}/assignments/{assignmentId}/cycles/{cycleId}/assignment-groups/{assignmentGroupId}/mark-as-completed/',
  )
  @override
  Future<void> markAssignmentGroupAsCompleted({
    @Path('assemblyId') required String assemblyId,
    @Path('assignmentId') required String assignmentId,
    @Path('assignmentGroupId') required String assignmentGroupId,
    @Path('cycleId') required String cycleId,
  });

  @POST(
    '/assemblies/{assemblyId}/assignments/{assignmentId}/cycles/{cycleId}/assignment-groups/{assignmentGroupId}/confirm-assignment-group-completion/',
  )
  @override
  Future<void> confirmAssignmentGroupCompletion({
    @Path('assemblyId') required String assemblyId,
    @Path('assignmentId') required String assignmentId,
    @Path('assignmentGroupId') required String assignmentGroupId,
    @Path('cycleId') required String cycleId,
  });
}
