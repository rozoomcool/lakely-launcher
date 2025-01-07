import 'package:drift/drift.dart';
import 'package:lakely/domain/db/database.dart';

class AppsService {
  final AppDatabase _db;

  AppsService(this._db);

  /// Получить все приложения
  Future<List<App>> getAllApps() async {
    return await _db.apps.select().get();
  }

  /// Получить приложение по ID
  Future<App?> getAppById(int id) async {
    return await (_db.apps.select()..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// Поиск приложения по названию
  Future<List<App>> searchAppsByTitle(String title) async {
    return await (_db.apps.select()
      ..where((tbl) => tbl.title.like('%$title%')))
        .get();
  }

  /// Добавить новое приложение
  Future<int> insertApp(AppsCompanion app) async {
    return await _db.apps.insert().insert(app);
  }

  /// Обновить существующее приложение
  Future<int> updateApp(int id, AppsCompanion app) async {
    return await (_db.apps.update()
      ..where((tbl) => tbl.id.equals(id)))
        .write(app);
  }

  /// Удалить приложение по ID
  Future<int> deleteApp(int id) async {
    return await (_db.apps.delete()
      ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  /// Проверить существование записи по имени пакета
  Future<bool> isAppExists(String packageName) async {
    final count = await (_db.apps.select()
      ..where((tbl) => tbl.packageName.equals(packageName)))
        .get();
    return count.isNotEmpty;
  }

  Future<void> addOrUpdateApp(AppsCompanion app) async {
    await _db.apps.insertOnConflictUpdate(app);
  }

  /// Удалить приложения, отсутствующие в списке packageNames
  Future<void> deleteMissingApps(Set<String> existingPackageNames) async {
    await (_db.apps.delete()
      ..where((tbl) => tbl.packageName.isNotIn(existingPackageNames)))
        .go();
  }
}
