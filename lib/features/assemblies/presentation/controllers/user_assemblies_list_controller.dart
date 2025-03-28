import 'package:assembly/features/assemblies/domain/entities/assembly.dart';
import 'package:assembly/features/assemblies/domain/usecases/get_assemblies_list_stream_usecase.dart';
import 'package:assembly/features/assemblies/presentation/providers/usecase_providers.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'user_assemblies_list_controller.g.dart';

@riverpod
Stream<List<Assembly>> userAssembliesListController(Ref ref) {
  return ref
      .watch(getAssembliesListStreamUsecaseProvider)
      .call(GetAssembliesListStreamParams(userId: 1))
      .fold(
        (l) => Stream.error(switch (l) {
          GetAssembliesListStreamFailure() =>
            LocaleKeys.failureLoadingUserAssembliesList.tr(),
        }),
        (r) => r,
      );
}
