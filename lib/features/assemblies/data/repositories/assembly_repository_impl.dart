import 'package:assembly/features/assemblies/domain/entities/assembly.dart';
import 'package:assembly/features/assemblies/domain/repositories/assembly_repository.dart';

abstract interface class AssemblyLocalDataSource {
  Stream<List<Assembly>> getUserAssembliesStream(int userId);
}

class AssemblyRepositoryImpl implements AssemblyRepository {
  final AssemblyLocalDataSource _assemblyLocalDataSource;

  AssemblyRepositoryImpl({
    required AssemblyLocalDataSource assemblyLocalDataSource,
  }) : _assemblyLocalDataSource = assemblyLocalDataSource;

  @override
  Stream<List<Assembly>> getUserAssembliesStream(int userId) =>
      _assemblyLocalDataSource.getUserAssembliesStream(userId);
}
