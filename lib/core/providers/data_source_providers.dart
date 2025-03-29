import 'package:assembly/core/data/datasources/updated_entities_record_local_data_source.dart';
import 'package:assembly/core/providers/database_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_source_providers.g.dart';

@riverpod
UpdatedEntitiesRecordLocalDataSource updatedEntitiesRecordLocalDataSource(
  Ref ref,
) {
  return UpdatedEntitiesRecordLocalDataSourceImpl(
    ref.watch(assemblyDatabaseProvider),
  );
}
