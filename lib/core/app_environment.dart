import 'package:envied/envied.dart';
part 'app_environment.g.dart';

@Envied(
  useConstantCase: true,
  obfuscate: true,
  requireEnvFile: true,
  allowOptionalFields: true,
)
abstract class AppEnvironment {
  @EnviedField()
  static final String serverBaseUrl = _AppEnvironment.serverBaseUrl;

  @EnviedField()
  static final bool debugModeEnabled = _AppEnvironment.debugModeEnabled;

  @EnviedField()
  static final String serverWebsocketsBaseUrl =
      _AppEnvironment.serverWebsocketsBaseUrl;
}
