import 'package:assembly/features/auth/data/repositories/server_token_repository_impl.dart';
import 'package:assembly/features/auth/domain/entities/server_token.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'server_token_remote_data_source.g.dart';

@RestApi()
abstract class ServerTokenRemoteDataSource extends ServerTokenDataSource {
  factory ServerTokenRemoteDataSource(
    Dio dio, {
    required String baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _ServerTokenRemoteDataSource;

  @override
  @POST('auth/login/')
  Future<ServerToken> getServerToken(@Field('id_token') String firebaseIdToken);
}
