import 'package:assembly/features/assemblies/data/repositories/assembly_repository_impl.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  test(
    'Test that the repository is fetching the data in the database',
    () async {
      AssemblyLocalDataSource assemblyLocalDataSource =
          MockAssemblyLocalDataSource();
      AssemblyRemoteDataSource assemblyRemoteDataSource =
          MockAssemblyRemoteDataSource();
      final assemblies = [
        Assembly(
          id: '1',
          name: 'Assembly 1',
          address: 'Address',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          userFounderId: 1,
        ),
      ];
      when(
        () => assemblyLocalDataSource.cacheAssemblies(any()),
      ).thenAnswer((invocation) => Future.value());
      when(
        () => assemblyRemoteDataSource.getUserAssemblies(),
      ).thenAnswer((invocation) => Future(() => assemblies));
      final repository = AssemblyRepositoryImpl(
        assemblyLocalDataSource: assemblyLocalDataSource,
        assemblyRemoteDataSource: assemblyRemoteDataSource,
      );
      await repository.fetchUserAssemblies();
      // Assert
      verify(() => assemblyLocalDataSource.cacheAssemblies(any())).called(1);
      verify(() => assemblyRemoteDataSource.getUserAssemblies()).called(1);
      verifyNoMoreInteractions(assemblyLocalDataSource);
      verifyNoMoreInteractions(assemblyRemoteDataSource);
    },
  );
}

class MockAssemblyLocalDataSource extends Mock
    implements AssemblyLocalDataSource {}

class MockAssemblyRemoteDataSource extends Mock
    implements AssemblyRemoteDataSource {}
