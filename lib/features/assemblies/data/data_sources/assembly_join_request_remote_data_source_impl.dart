import 'package:assembly/features/assemblies/data/repositories/assembly_join_request_repository_impl.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly_join_request.dart';
import 'package:assembly/features/assemblies/domain/models/assembly_join_request_body_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'assembly_join_request_remote_data_source_impl.g.dart';

@RestApi()
abstract class AssemblyJoinRequestRemoteDataSourceImpl
    implements AssemblyJoinRequestRemoteDataSource {
  factory AssemblyJoinRequestRemoteDataSourceImpl(
    Dio dio, {
    required String baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _AssemblyJoinRequestRemoteDataSourceImpl;

  @POST('/assemblies/{assemblyId}/join-requests/')
  @override
  Future<AssemblyJoinRequest> postAssemblyJoinRequest(
    @Path('assemblyId') String assemblyId,
    @Body() AssemblyJoinRequestBodyRequest assemblyJoinRequestBodyRequest,
  );

  @GET('/assemblies/{assemblyId}/join-requests/')
  @override
  Future<List<AssemblyJoinRequest>> getAssemblyJoinRequests(
    @Path('assemblyId') String assemblyId,
  );

  @POST('/assemblies/{assemblyId}/join-requests/{joinRequestId}/accept/')
  @override
  Future<void> acceptJoinRequest(
    @Path('assemblyId') String assemblyId,
    @Path('joinRequestId') String joinRequestId,
  );

  @POST('/assemblies/{assemblyId}/join-requests/{joinRequestId}/reject/')
  @override
  Future<void> rejectJoinRequest(
    @Path('assemblyId') String assemblyId,
    @Path('joinRequestId') String joinRequestId,
  );
}
