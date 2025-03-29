import 'package:assembly/features/assemblies/data/repositories/assembly_repository_impl.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly.dart';
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
  Future<List<Assembly>> getUserAssemblies();
}
