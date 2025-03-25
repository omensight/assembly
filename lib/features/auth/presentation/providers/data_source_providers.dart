import 'package:assembly/core/providers/database_providers.dart';
import 'package:assembly/features/auth/data/data_sources/server_token_local_data_source_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:assembly/core/providers/client_providers.dart';
import 'package:assembly/features/auth/data/data_sources/server_token_remote_data_source_impl.dart';
import 'package:assembly/features/auth/data/repositories/server_token_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_source_providers.g.dart';

@riverpod
ServerTokenRemoteDataSource serverTokenRemoteDataSource(Ref ref) {
  return ServerTokenRemoteDataSourceImpl(
    ref.watch(authenticationDioProvider),
    baseUrl: ref.watch(baseUrlProvider),
  );
}

@riverpod
ServerTokenLocalDataSource serverTokenLocalDataSource(Ref ref) {
  return ServerTokenLocalDataSourceImpl(ref.watch(assemblyDatabaseProvider));
}
