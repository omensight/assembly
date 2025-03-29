import 'package:assembly/core/data/database/assembly_database.dart';
import 'package:assembly/core/data/entities/updated_entities_records.dart';
import 'package:drift/drift.dart';
part 'updated_entities_record_local_data_source.g.dart';

abstract interface class UpdatedEntitiesRecordLocalDataSource {
  Future<UpdatedEntitiesRecord> getUpdatedEntityRecord();
  Future<void> updateRecord(UpdatedEntitiesRecord updatedEntitiesRecord);
}

@DriftAccessor(tables: [UpdatedEntitiesRecords])
class UpdatedEntitiesRecordLocalDataSourceImpl
    extends DatabaseAccessor<AssemblyDatabase>
    with _$UpdatedEntitiesRecordLocalDataSourceImplMixin
    implements UpdatedEntitiesRecordLocalDataSource {
  UpdatedEntitiesRecordLocalDataSourceImpl(super.attachedDatabase);

  @override
  Future<UpdatedEntitiesRecord> getUpdatedEntityRecord() async {
    final record =
        await (select(updatedEntitiesRecords)..where(
          (tbl) => tbl.id.equals(uniqueUpdatedEntitiesRecordId),
        )).getSingleOrNull();
    if (record == null) {
      into(
        updatedEntitiesRecords,
      ).insert(UpdatedEntitiesRecord(id: uniqueUpdatedEntitiesRecordId));
    }
    return await (select(updatedEntitiesRecords)..where(
      (tbl) => tbl.id.equals(uniqueUpdatedEntitiesRecordId),
    )).getSingle();
  }

  @override
  Future<void> updateRecord(UpdatedEntitiesRecord updatedEntitiesRecord) async {
    await into(
      updatedEntitiesRecords,
    ).insertOnConflictUpdate(updatedEntitiesRecord);
  }
}
