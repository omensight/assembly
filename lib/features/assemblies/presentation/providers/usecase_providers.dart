import 'package:assembly/features/assemblies/domain/usecases/accept_join_request_usecase.dart';
import 'package:assembly/features/assemblies/domain/usecases/create_assembly_join_request_usecase.dart';
import 'package:assembly/features/assemblies/domain/usecases/create_assembly_usecase.dart';
import 'package:assembly/features/assemblies/domain/usecases/fetch_user_assemblies_usecase.dart';
import 'package:assembly/features/assemblies/domain/usecases/get_assemblies_list_stream_usecase.dart';
import 'package:assembly/features/assemblies/domain/usecases/get_assembly_by_join_code_usecase.dart';
import 'package:assembly/features/assemblies/domain/usecases/get_assembly_join_code_usecase.dart';
import 'package:assembly/features/assemblies/domain/usecases/get_assembly_join_requests_usecase.dart';
import 'package:assembly/features/assemblies/domain/usecases/get_assembly_stream_usecase.dart';
import 'package:assembly/features/assemblies/domain/usecases/get_current_assembly_member_usecase.dart';
import 'package:assembly/features/assemblies/domain/usecases/reject_join_request_usecase.dart';
import 'package:assembly/features/assemblies/presentation/providers/repository_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'usecase_providers.g.dart';

@riverpod
GetAssembliesListStreamUsecase getAssembliesListStreamUsecase(Ref ref) {
  return GetAssembliesListStreamUsecase(
    assemblyRepository: ref.watch(assemblyRepositoryProvider),
  );
}

@riverpod
FetchUserAssembliesUsecase fetchUserAssembliesUsecase(Ref ref) {
  return FetchUserAssembliesUsecase(
    assemblyRepository: ref.watch(assemblyRepositoryProvider),
  );
}

@riverpod
CreateAssemblyUsecase createAssemblyUsecase(Ref ref) {
  return CreateAssemblyUsecase(
    assemblyRepository: ref.watch(assemblyRepositoryProvider),
  );
}

@riverpod
GetAssemblyStreamUsecase getAssemblyStreamUsecase(Ref ref) {
  return GetAssemblyStreamUsecase(
    assemblyRepository: ref.watch(assemblyRepositoryProvider),
  );
}

@riverpod
GetAssemblyJoinCodeUsecase getAssemblyJoinCodeUsecase(Ref ref) {
  return GetAssemblyJoinCodeUsecase(
    assemblyRepository: ref.watch(assemblyRepositoryProvider),
  );
}

@riverpod
GetAssemblyByJoinCodeUsecase getAssemblyByJoinCodeUsecase(Ref ref) {
  return GetAssemblyByJoinCodeUsecase(
    assemblyRepository: ref.watch(assemblyRepositoryProvider),
  );
}

@riverpod
CreateAssemblyJoinRequestUsecase createAssemblyJoinRequestUsecase(Ref ref) {
  return CreateAssemblyJoinRequestUsecase(
    assemblyJoinRequestRepository: ref.watch(
      assemblyJoinRequestRepositoryProvider,
    ),
  );
}

@riverpod
GetAssemblyJoinRequestsUsecase getAssemblyJoinRequestsUsecase(Ref ref) {
  return GetAssemblyJoinRequestsUsecase(
    assemblyJoinRequestRepository: ref.watch(
      assemblyJoinRequestRepositoryProvider,
    ),
  );
}

@riverpod
AcceptJoinRequestUsecase acceptJoinRequestUsecase(Ref ref) {
  return AcceptJoinRequestUsecase(
    assemblyJoinRequestRepository: ref.watch(
      assemblyJoinRequestRepositoryProvider,
    ),
  );
}

@riverpod
RejectJoinRequestUsecase rejectJoinRequestUsecase(Ref ref) {
  return RejectJoinRequestUsecase(
    assemblyJoinRequestRepository: ref.watch(
      assemblyJoinRequestRepositoryProvider,
    ),
  );
}

@riverpod
GetCurrentAssemblyMemberUseCase getCurrentAssemblyMemberUsecase(Ref ref) {
  return GetCurrentAssemblyMemberUseCase(
    assemblyRepository: ref.watch(assemblyRepositoryProvider),
  );
}
