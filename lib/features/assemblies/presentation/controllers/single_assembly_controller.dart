import 'package:assembly/features/assemblies/domain/entities/assembly.dart';
import 'package:assembly/features/assemblies/domain/usecases/get_assembly_stream_usecase.dart';
import 'package:assembly/features/assemblies/presentation/providers/usecase_providers.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'single_assembly_controller.g.dart';

@riverpod
Stream<Assembly?> singleAssemblyController(Ref ref, String assemblyId) {
  return ref
      .read(getAssemblyStreamUsecaseProvider)(
        GetAssemblyStreamParams(assemblyId: assemblyId),
      )
      .fold(
        (l) => Stream.error(switch (l) {
          GetAssemblyStreamFailure() =>
            LocaleKeys.failureLoadingTheAssembly.tr(),
        }),
        (r) => r,
      );
}
