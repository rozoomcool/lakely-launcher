import 'package:drift/drift.dart';
import 'package:lakely/domain/entity/apps.dart';

class HomeApps extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get appId => integer().references(Apps, #id, onDelete: KeyAction.cascade).unique()();
  IntColumn get position => integer()();
}