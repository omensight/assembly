import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:assembly/features/auth/domain/usecases/login_into_the_server_usecase.dart';
import 'package:assembly/features/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:assembly/features/auth/presentation/providers/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'usecase_providers.g.dart';

@riverpod
LoginWithGoogleUsecase loginWithGoogleUsecase(Ref ref) {
  return LoginWithGoogleUsecase();
}

@riverpod
LoginIntoTheServerUsecase loginIntoTheServerUsecase(Ref ref) {
  return LoginIntoTheServerUsecase(
    serverTokenRepository: ref.watch(serverTokenRepositoryProvider),
  );
}
