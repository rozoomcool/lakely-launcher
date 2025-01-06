import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:lakely/domain/entity/apps.dart';
import 'package:lakely/domain/entity/home_apps.dart';
import 'package:lakely/domain/entity/notes.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Notes, Apps, HomeApps])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'my_database');
  }
}