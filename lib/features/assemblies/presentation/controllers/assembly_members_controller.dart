import 'package:assembly/features/assemblies/domain/entities/assembly_member.dart';
import 'package:assembly/features/assemblies/domain/usecases/get_assembly_members_usecase.dart';
import 'package:assembly/features/assemblies/presentation/providers/usecase_providers.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assembly_members_controller.g.dart';

@riverpod
class AssemblyMembersController extends _$AssemblyMembersController {
  @override
  FutureOr<List<AssemblyMember>> build(String assemblyId) async {
    final getAssemblyMembersUsecase = ref.read(
      getAssemblyMembersUsecaseProvider,
    );

    final result =
        await getAssemblyMembersUsecase
            .build(GetAssemblyMembersParams(assemblyId: assemblyId))
            .run();

    return result.fold((failure) {
      final errorMessage = switch (failure) {
        NetworkFailure() => LocaleKeys.failureLoadingAssemblyMembers.tr(),
      };
      return Future.error(errorMessage);
    }, (members) => members);
  }
}
