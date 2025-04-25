import 'package:assembly/core/data/database/assembly_database.dart';
import 'package:assembly/core/data/datasources/updated_entities_record_local_data_source.dart';
import 'package:assembly/features/assemblies/data/repositories/assembly_repository_impl.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(UpdatedEntitiesRecord(id: 0));
  });
  test(
    'Test that the repository is fetching the data in the database',
    () async {
      AssemblyLocalDataSource assemblyLocalDataSource =
          MockAssemblyLocalDataSource();
      AssemblyRemoteDataSource assemblyRemoteDataSource =
          MockAssemblyRemoteDataSource();
      UpdatedEntitiesRecordLocalDataSource
      updatedEntitiesRecordLocalDataSource =
          MockUpdatedEntitiesRecordLocalDataSource();
      final assemblies = [
        Assembly(
          id: '1',
          name: 'Assembly 1',
          address: 'Address',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          isActive: true,
          userFounderId: 1,
        ),
      ];
      when(
        () => assemblyLocalDataSource.cacheAssemblies(any()),
      ).thenAnswer((invocation) => Future.value());
      when(
        () => assemblyRemoteDataSource.getUserAssemblies(any()),
      ).thenAnswer((invocation) => Future(() => assemblies));
      when(
        () => updatedEntitiesRecordLocalDataSource.getUpdatedEntityRecord(),
      ).thenAnswer(
        (invocation) => Future(
          () => UpdatedEntitiesRecord(id: 0, assemblies: DateTime.now()),
        ),
      );
      when(
        () => updatedEntitiesRecordLocalDataSource.updateRecord(any()),
      ).thenAnswer((invocation) => Future.value());

      final repository = AssemblyRepositoryImpl(
        assemblyLocalDataSource: assemblyLocalDataSource,
        assemblyRemoteDataSource: assemblyRemoteDataSource,
        updatedEntitiesRecordLocalDataSource:
            updatedEntitiesRecordLocalDataSource,
      );
      await repository.fetchUserAssemblies();
      // Assert
      verify(() => assemblyLocalDataSource.cacheAssemblies(any())).called(1);
      verify(() => assemblyRemoteDataSource.getUserAssemblies(any())).called(1);
      verifyNoMoreInteractions(assemblyLocalDataSource);
      verifyNoMoreInteractions(assemblyRemoteDataSource);
    },
  );
}

class MockAssemblyLocalDataSource extends Mock
    implements AssemblyLocalDataSource {}

class MockAssemblyRemoteDataSource extends Mock
    implements AssemblyRemoteDataSource {}

class MockUpdatedEntitiesRecordLocalDataSource extends Mock
    implements UpdatedEntitiesRecordLocalDataSource {}
