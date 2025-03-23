import 'package:assembly/features/auth/domain/entities/server_token.dart';
import 'package:assembly/features/auth/domain/repositories/server_token_repository.dart';

abstract class ServerTokenDataSource {
  Future<ServerToken> getServerToken(String firebaseIdToken);
}

class ServerTokenRepositoryImpl extends ServerTokenRepository {
  ServerTokenRepositoryImpl({
    required ServerTokenDataSource tokenServerDataSource,
  }) : _tokenServerRemoteDataSource = tokenServerDataSource;

  final ServerTokenDataSource _tokenServerRemoteDataSource;

  @override
  Future<ServerToken> getServerToken({required String firebaseIdToken}) {
    return _tokenServerRemoteDataSource.getServerToken(firebaseIdToken);
  }
}
