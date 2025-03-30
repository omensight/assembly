import 'package:assembly/features/assemblies/domain/entities/assembly.dart';
import 'package:assembly/features/assemblies/domain/models/assembly_create_request.dart';

abstract interface class AssemblyRepository {
  Stream<List<Assembly>> getUserAssembliesStream(int userId);

  Future<void> fetchUserAssemblies();

  Future<Assembly> createAssembly(AssemblyCreateRequest assemblyCreateRequest);
}
