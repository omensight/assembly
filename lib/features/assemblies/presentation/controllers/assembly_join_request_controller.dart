import 'package:assembly/features/assemblies/domain/entities/assembly_join_request.dart';
import 'package:assembly/features/assemblies/domain/usecases/create_assembly_join_request_usecase.dart';
import 'package:assembly/features/assemblies/presentation/providers/usecase_providers.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assembly_join_request_controller.g.dart';

@riverpod
class AssemblyJoinRequestController extends _$AssemblyJoinRequestController {
  @override
  FutureOr<AssemblyJoinRequest?> build(
    String assemblyId,
    String joinRequestCode,
  ) {
    return null;
  }

  Future<void> requestAccess() async {
    state = (await ref
            .read(createAssemblyJoinRequestUsecaseProvider)
            .build(
              CreateAssemblyJoinRequestParams(
                assemblyId: assemblyId,
                joinRequestCode: joinRequestCode,
              ),
            )
            .run())
        .fold(
          (l) => AsyncError(switch (l) {
            NetworkFailure() => LocaleKeys.failureRequestingAssemblyJoin.tr(),
          }, StackTrace.current),
          (r) => AsyncData(r),
        );
  }
}
