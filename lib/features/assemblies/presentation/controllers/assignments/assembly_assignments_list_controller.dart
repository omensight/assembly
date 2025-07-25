import 'package:assembly/features/assemblies/domain/entities/assignment.dart';
import 'package:assembly/features/assemblies/domain/usecases/assignments/get_assembly_assignments_list.dart';
import 'package:assembly/features/assemblies/presentation/providers/usecase_providers.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'assembly_assignments_list_controller.g.dart';

@riverpod
class AssemblyAssignmentsListController
    extends _$AssemblyAssignmentsListController {
  @override
  FutureOr<List<Assignment>> build(String assemblyId) async {
    return (await ref
            .watch(getAssemblyAssignmentsListUsecaseProvider)
            .build(GetAssemblyAssignmentsListParams(assemblyId: assemblyId))
            .run())
        .fold(
          (l) => Future.error(switch (l) {
            GetAssemblyAssignmentsNetworkFailure() =>
              LocaleKeys.failureLoadingAssemblyAssigments.tr(),
          }),
          (r) => r,
        );
  }
}
