import 'package:assembly/features/assemblies/domain/usecases/accept_join_request_usecase.dart';
import 'package:assembly/features/assemblies/presentation/providers/usecase_providers.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accept_join_request_controller.g.dart';

@riverpod
class AcceptJoinRequestController extends _$AcceptJoinRequestController {
  @override
  FutureOr<bool> build(String assemblyId, String joinRequestId) async {
    return false;
  }

  Future<void> acceptRequest() async {
    state = const AsyncLoading();

    final acceptJoinRequestUsecase = ref.read(acceptJoinRequestUsecaseProvider);
    final result =
        await acceptJoinRequestUsecase
            .build(
              AcceptJoinRequestParams(
                assemblyId: assemblyId,
                joinRequestId: joinRequestId,
              ),
            )
            .run();

    state = result.fold(
      (failure) {
        final errorMessage = switch (failure) {
          NetworkFailure() => LocaleKeys.failureAcceptingJoinRequest.tr(),
        };
        return AsyncError(errorMessage, StackTrace.current);
      },
      (_) {
        return AsyncData(true);
      },
    );
  }
}
