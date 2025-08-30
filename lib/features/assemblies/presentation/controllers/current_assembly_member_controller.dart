import 'package:assembly/features/assemblies/domain/entities/assembly_member.dart';
import 'package:assembly/features/assemblies/domain/usecases/get_current_assembly_member_usecase.dart';
import 'package:assembly/features/assemblies/presentation/providers/usecase_providers.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_assembly_member_controller.g.dart';

@riverpod
FutureOr<AssemblyMember> currentAssemblyMember(
  Ref ref,
  String assemblyId,
) async {
  return (await ref
          .watch(getCurrentAssemblyMemberUsecaseProvider)
          .build(GetCurrentAssemblyMemberParams(assemblyId: assemblyId))
          .run())
      .fold(
        (l) => Future.error(switch (l) {
          RetrieveFailure() =>
            LocaleKeys.failureLoadingCurrentAssemblyMember.tr(),
        }),
        (r) => r,
      );
}

@riverpod
AssemblyMemberRole currentAssemblyMemberRole(Ref ref, String assemblyId) {
  return ref
      .watch(currentAssemblyMemberProvider(assemblyId))
      .when(
        data: (data) => data.role,
        error: (error, stackTrace) => AssemblyMemberRole.member,
        loading: () => AssemblyMemberRole.member,
      );
}
