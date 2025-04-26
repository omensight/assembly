import 'package:assembly/features/assemblies/data/repositories/assembly_repository_impl.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly_join_code.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly_member.dart';
import 'package:assembly/features/assemblies/domain/models/assembly_create_request.dart';
import 'package:assembly/features/assemblies/domain/models/assembly_update_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'assembly_remote_data_source_impl.g.dart';

@RestApi()
abstract class AssemblyRemoteDataSourceImpl
    implements AssemblyRemoteDataSource {
  factory AssemblyRemoteDataSourceImpl(
    Dio dio, {
    required String baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _AssemblyRemoteDataSourceImpl;

  @GET('/assemblies/')
  @override
  Future<List<Assembly>> getUserAssemblies(
    @Query('updated_after') DateTime? updatedAfter,
  );

  @POST('/assemblies/')
  @override
  Future<Assembly> postAssembly(
    @Body() AssemblyCreateRequest assemblyCreateRequest,
  );

  @PATCH('/assemblies/{assemblyId}/')
  @override
  Future<Assembly> updateAssembly(
    @Path('assemblyId') String assemblyId,
    @Body() AssemblyUpdateRequest assemblyUpdateRequest,
  );

  @GET('/assemblies/{assemblyId}/join-code/')
  @override
  Future<AssemblyJoinCode> getAssemblyJoinCode(
    @Path('assemblyId') String assemblyId,
    @Query('refresh') bool refresh,
  );

  @GET('/assemblies/find-by-join-code/')
  @override
  Future<Assembly> getAssemblyByJoinCode(@Query('join_code') String joinCode);

  @GET('/assemblies/{assemblyId}/current-member/')
  @override
  Future<AssemblyMember> getCurrentAssemblyMember(
    @Path('assemblyId') String assemblyId,
  );

  @GET('/assemblies/{assemblyId}/members/')
  @override
  Future<List<AssemblyMember>> getAssemblyMembers(
    @Path('assemblyId') String assemblyId,
  );
}
