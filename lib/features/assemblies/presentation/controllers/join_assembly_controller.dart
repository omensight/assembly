import 'package:assembly/features/assemblies/domain/entities/assembly.dart';
import 'package:assembly/features/assemblies/domain/usecases/get_assembly_by_join_code_usecase.dart';
import 'package:assembly/features/assemblies/presentation/providers/usecase_providers.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'join_assembly_controller.g.dart';

@riverpod
class JoinAssemblyController extends _$JoinAssemblyController {
  @override
  FutureOr<Assembly?> build() {
    return null;
  }

  Future<void> startJoinRequest(String joinCode) async {
    state = (await ref
            .watch(getAssemblyByJoinCodeUsecaseProvider)
            .build(GetAssemblyByJoinCodeParams(joinCode: joinCode))
            .run())
        .fold(
          (l) => AsyncError(switch (l) {
            NetworkFailure() => LocaleKeys.failureLoadingTheAssembly.tr(),
          }, StackTrace.current),
          (r) => AsyncValue.data(r),
        );
  }

  void resetValue() {
    state = AsyncData(null);
  }
}
