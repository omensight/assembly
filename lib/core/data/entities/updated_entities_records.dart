import 'package:drift/drift.dart';

const uniqueUpdatedEntitiesRecordId = 1;

class UpdatedEntitiesRecords extends Table {
  IntColumn get id => integer()();
  DateTimeColumn get assemblies => dateTime().nullable()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
