import 'package:drift/drift.dart';

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 0, max: 128)();
  TextColumn get content => text()();
  DateTimeColumn get createdAt => dateTime().nullable()();
}