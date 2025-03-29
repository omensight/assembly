import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/features/assemblies/presentation/providers/usecase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_sync_controller.g.dart';

@riverpod
class DataSyncController extends _$DataSyncController {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<void> syncAssemblies() async {
    await ref.read(fetchUserAssembliesUsecaseProvider).build(NoParams()).run();
  }
}
