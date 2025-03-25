import 'package:assembly/features/auth/data/repositories/server_token_repository_impl.dart';
import 'package:assembly/features/auth/domain/entities/server_token.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'server_token_remote_data_source_impl.g.dart';

@RestApi()
abstract class ServerTokenRemoteDataSourceImpl
    extends ServerTokenRemoteDataSource {
  factory ServerTokenRemoteDataSourceImpl(
    Dio dio, {
    required String baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _ServerTokenRemoteDataSourceImpl;

  @override
  @POST('auth/login/')
  Future<ServerToken> getServerToken(@Field('id_token') String firebaseIdToken);
}
