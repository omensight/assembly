import 'package:assembly/features/auth/domain/entities/server_token.dart';
import 'package:assembly/features/auth/domain/repositories/server_token_repository.dart';

abstract class ServerTokenRemoteDataSource {
  Future<ServerToken> getServerToken(String firebaseIdToken);
}

abstract class ServerTokenLocalDataSource {
  Future<void> save(ServerToken serverToken);
  Stream<ServerToken?> getServerTokenStream();
}

class ServerTokenRepositoryImpl extends ServerTokenRepository {
  ServerTokenRepositoryImpl({
    required ServerTokenRemoteDataSource tokenServerRemoteDataSource,
    required ServerTokenLocalDataSource serverTokenLocalDataSource,
  }) : _tokenServerRemoteDataSource = tokenServerRemoteDataSource,
       _serverTokenLocalDataSource = serverTokenLocalDataSource;

  final ServerTokenRemoteDataSource _tokenServerRemoteDataSource;
  final ServerTokenLocalDataSource _serverTokenLocalDataSource;

  @override
  Future<ServerToken> getServerToken({required String firebaseIdToken}) {
    return _tokenServerRemoteDataSource.getServerToken(firebaseIdToken);
  }

  @override
  Future<void> saveServerToken(ServerToken serverToken) async {
    _serverTokenLocalDataSource.save(serverToken);
  }

  @override
  Stream<ServerToken?> getServerTokenStream() {
    return _serverTokenLocalDataSource.getServerTokenStream();
  }
}
