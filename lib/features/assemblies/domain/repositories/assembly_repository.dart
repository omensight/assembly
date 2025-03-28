import 'package:assembly/features/assemblies/domain/entities/assembly.dart';

abstract interface class AssemblyRepository {
  Stream<List<Assembly>> getUserAssembliesStream(int userId);
}
