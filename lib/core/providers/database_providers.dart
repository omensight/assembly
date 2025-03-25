import 'package:assembly/core/data/database/assembly_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
part 'database_providers.g.dart';

@riverpod
AssemblyDatabase assemblyDatabase(Ref ref) {
  final executor = driftDatabase(
    name: 'assembly_db',
    native: const DriftNativeOptions(
      databaseDirectory: getApplicationSupportDirectory,
    ),
  );
  return AssemblyDatabase(executor);
}
