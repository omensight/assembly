import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:assembly/core/providers/client_providers.dart';
import 'package:assembly/features/auth/data/data_sources/server_token_remote_data_source.dart';
import 'package:assembly/features/auth/data/repositories/server_token_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_source_providers.g.dart';

@riverpod
ServerTokenDataSource serverTokenDataSource(Ref ref) {
  return ServerTokenRemoteDataSource(
    ref.watch(authenticationDioProvider),
    baseUrl: ref.watch(baseUrlProvider),
  );
}
