import 'package:assembly/features/assemblies/domain/entities/assembly.dart';
import 'package:assembly/features/assemblies/domain/models/assembly_update_request.dart';
import 'package:assembly/features/assemblies/domain/usecases/update_assembly_usecase.dart';
import 'package:assembly/features/assemblies/presentation/providers/usecase_providers.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_assembly_controller.g.dart';

@riverpod
class UpdateAssemblyController extends _$UpdateAssemblyController {
  @override
  FutureOr<Assembly?> build(String assemblyId) async {
    return null;
  }

  Future<void> updateAssembly({
    required String name,
    required String address,
    bool? isActive,
  }) async {
    state = const AsyncLoading();

    final updateAssemblyUsecase = ref.read(updateAssemblyUsecaseProvider);
    final assemblyUpdateRequest = AssemblyUpdateRequest(
      name: name,
      address: address,
      isActive: isActive,
    );

    final result =
        await updateAssemblyUsecase
            .build(
              UpdateAssemblyParams(
                assemblyId: assemblyId,
                assemblyUpdateRequest: assemblyUpdateRequest,
              ),
            )
            .run();

    state = result.fold((failure) {
      final errorMessage = switch (failure) {
        NetworkFailure() => LocaleKeys.failureUpdatingAssembly.tr(),
      };
      return AsyncError(errorMessage, StackTrace.current);
    }, (assembly) => AsyncData(assembly));
  }
}
