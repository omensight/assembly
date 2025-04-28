import 'package:assembly/features/assemblies/data/data_sources/assignment_remote_data_source.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment.dart';
import 'package:assembly/features/assemblies/domain/models/assignment_create_request.dart';
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
}
