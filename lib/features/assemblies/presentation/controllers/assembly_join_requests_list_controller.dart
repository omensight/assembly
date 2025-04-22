import 'package:assembly/features/assemblies/domain/entities/assembly_join_request.dart';
import 'package:assembly/features/assemblies/domain/usecases/get_assembly_join_requests_usecase.dart';
import 'package:assembly/features/assemblies/presentation/providers/usecase_providers.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assembly_join_requests_list_controller.g.dart';

@riverpod
class AssemblyJoinRequestsListController
    extends _$AssemblyJoinRequestsListController {
  @override
  FutureOr<List<AssemblyJoinRequest>> build(String assemblyId) async {
    final getAssemblyJoinRequestsUsecase = ref.read(
      getAssemblyJoinRequestsUsecaseProvider,
    );

    final result =
        await getAssemblyJoinRequestsUsecase
            .build(GetAssemblyJoinRequestsParams(assemblyId: assemblyId))
            .run();

    return result.fold((l) {
      final errorMessage = switch (l) {
        NetworkFailure() => LocaleKeys.failureLoadingJoinRequests.tr(),
      };
      return Future.error(errorMessage);
    }, (r) => r);
  }

  Future<void> removeRequestById(String requestId) async {
    final currentState = state;
    if (currentState is AsyncData) {
      final updatedRequests =
          currentState.value!
              .where((request) => request.id != requestId)
              .toList();
      state = AsyncData(updatedRequests);
    }
  }
}
