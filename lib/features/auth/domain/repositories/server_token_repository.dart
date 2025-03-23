import 'package:assembly/features/auth/domain/entities/server_token.dart';

abstract class ServerTokenRepository {
  Future<ServerToken> getServerToken({required String firebaseIdToken});
}
