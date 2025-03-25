import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:assembly/features/auth/data/repositories/server_token_repository_impl.dart';
import 'package:assembly/features/auth/domain/repositories/server_token_repository.dart';
import 'package:assembly/features/auth/presentation/providers/data_source_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_providers.g.dart';

@riverpod
ServerTokenRepository serverTokenRepository(Ref ref) {
  return ServerTokenRepositoryImpl(
    tokenServerRemoteDataSource: ref.watch(serverTokenRemoteDataSourceProvider),
    serverTokenLocalDataSource: ref.watch(serverTokenLocalDataSourceProvider),
  );
}
