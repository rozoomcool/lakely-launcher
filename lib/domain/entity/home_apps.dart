import 'package:drift/drift.dart';

class HomeApps extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get appId => integer().customConstraint('REFERENCES apps(id) ON DELETE CASCADE')();
  IntColumn get position => integer().unique()();
}