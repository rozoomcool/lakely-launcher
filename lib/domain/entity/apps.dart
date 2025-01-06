import 'package:drift/drift.dart';

class Apps extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 0, max: 128)();
  TextColumn get packageName => text().unique()();
  BlobColumn get icon => blob()();
}