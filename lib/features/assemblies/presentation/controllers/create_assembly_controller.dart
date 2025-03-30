import 'package:assembly/features/assemblies/domain/entities/assembly.dart';
import 'package:assembly/features/assemblies/domain/usecases/create_assembly_usecase.dart';
import 'package:assembly/features/assemblies/presentation/providers/usecase_providers.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_assembly_controller.g.dart';

@riverpod
class CreateAssemblyController extends _$CreateAssemblyController {
  @override
  Future<Assembly?> build() async {
    return null;
  }

  Future<void> submitAssembly({
    required String name,
    required String address,
  }) async {
    state = AsyncLoading();
    state = (await ref
            .read(createAssemblyUsecaseProvider)
            .build(CreateAssemblyParams(name: name, address: address))
            .run())
        .fold(
          (l) => switch (l) {
            NetworkFailure() => AsyncError(
              LocaleKeys.failureCreatingTheAssembly.tr(),
              StackTrace.current,
            ),
          },
          (r) => AsyncData(r),
        );
  }
}
