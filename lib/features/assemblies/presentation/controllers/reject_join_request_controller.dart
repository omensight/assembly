import 'package:assembly/features/assemblies/domain/usecases/reject_join_request_usecase.dart';
import 'package:assembly/features/assemblies/presentation/providers/usecase_providers.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reject_join_request_controller.g.dart';

@riverpod
class RejectJoinRequestController extends _$RejectJoinRequestController {
  @override
  FutureOr<bool> build(String assemblyId, String joinRequestId) async {
    return false;
  }

  Future<void> rejectRequest() async {
    state = const AsyncLoading();

    final rejectJoinRequestUsecase = ref.read(rejectJoinRequestUsecaseProvider);
    final result =
        await rejectJoinRequestUsecase
            .build(
              RejectJoinRequestParams(
                assemblyId: assemblyId,
                joinRequestId: joinRequestId,
              ),
            )
            .run();

    state = result.fold(
      (failure) {
        final errorMessage = switch (failure) {
          NetworkFailure() => LocaleKeys.failureRejectingJoinRequest.tr(),
        };
        return AsyncError(errorMessage, StackTrace.current);
      },
      (_) {
        return AsyncData(true);
      },
    );
  }
}
