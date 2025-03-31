import 'package:assembly/core/error/failure.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly_join_code.dart';
import 'package:assembly/features/assemblies/domain/usecases/get_assembly_join_code_usecase.dart';
import 'package:assembly/features/assemblies/presentation/providers/usecase_providers.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assembly_join_code_controller.g.dart';

@riverpod
class AssemblyJoinCodeController extends _$AssemblyJoinCodeController {
  @override
  Future<AssemblyJoinCode> build(String assemblyId) async {
    return (await retrieveAssemblyJoinCode(assemblyId, false)).fold(
      (l) => Future.error(switch (l) {
        Failure() => LocaleKeys.failureLoadingTheAssemblyJoinCode.tr(),
      }),
      (r) => Future.value(r),
    );
  }

  Future<Either<Failure, AssemblyJoinCode>> retrieveAssemblyJoinCode(
    String assemblyId,
    bool refresh,
  ) async {
    return (await ref
        .read(getAssemblyJoinCodeUsecaseProvider)
        .build(
          GetAssemblyJoinCodeParams(assemblyId: assemblyId, refresh: refresh),
        )
        .run());
  }

  Future<void> refreshCode() async {
    state = AsyncLoading();
    state = (await retrieveAssemblyJoinCode(assemblyId, true)).fold(
      (l) => AsyncError(switch (l) {
        Failure() => LocaleKeys.failureLoadingTheAssemblyJoinCode.tr(),
      }, StackTrace.current),
      (r) => AsyncData(r),
    );
  }
}
