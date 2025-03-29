import 'package:assembly/features/assemblies/domain/entities/assembly.dart';
import 'package:assembly/features/assemblies/domain/repositories/assembly_repository.dart';

abstract interface class AssemblyLocalDataSource {
  Stream<List<Assembly>> getUserAssembliesStream(int userId);
  Future<void> cacheAssemblies(List<Assembly> newAssemblies);
}

abstract interface class AssemblyRemoteDataSource {
  Future<List<Assembly>> getUserAssemblies();
}

class AssemblyRepositoryImpl implements AssemblyRepository {
  final AssemblyLocalDataSource _assemblyLocalDataSource;
  final AssemblyRemoteDataSource _assemblyRemoteDataSource;

  AssemblyRepositoryImpl({
    required AssemblyLocalDataSource assemblyLocalDataSource,
    required AssemblyRemoteDataSource assemblyRemoteDataSource,
  }) : _assemblyLocalDataSource = assemblyLocalDataSource,
       _assemblyRemoteDataSource = assemblyRemoteDataSource;

  @override
  Stream<List<Assembly>> getUserAssembliesStream(int userId) =>
      _assemblyLocalDataSource.getUserAssembliesStream(userId);

  @override
  Future<void> fetchUserAssemblies() async {
    final assemblies = await _assemblyRemoteDataSource.getUserAssemblies();
    _assemblyLocalDataSource.cacheAssemblies(assemblies);
  }
}
