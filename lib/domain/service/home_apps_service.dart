import 'package:drift/drift.dart';
import 'package:lakely/domain/db/database.dart';

class HomeAppsService {
  final AppDatabase _db;

  HomeAppsService(this._db);

  /// Получить все HomeApps с подгрузкой связанных приложений
  Future<List<HomeAppWithDetails>> getAllHomeAppsWithDetails() async {
    final query = _db.select(_db.homeApps).join([
      leftOuterJoin(_db.apps, _db.apps.id.equalsExp(_db.homeApps.appId)),
    ]);

    final result = await query.get();

    return result.map((row) {
      final homeApp = row.readTable(_db.homeApps);
      final app = row.readTable(_db.apps);
      return HomeAppWithDetails(
          id: homeApp.id, position: homeApp.position, app: app);
    }).toList();
  }

  /// Добавить запись в HomeApps
  Future<void> addHomeApp(int appId) async {
    final apps = await (_db.apps.select()..where((tbl) => tbl.id.equals(appId)))
        .get();
    final app = apps.isNotEmpty ? apps.first : null;
    if (app == null) return;
    final position = await _getNextPosition();
    await _db.homeApps.insertOnConflictUpdate(
      HomeAppsCompanion.insert(appId: appId, position: position),
    );
  }

  /// Удалить запись из HomeApps
  Future<void> deleteHomeApp(int id) async {
    await (_db.homeApps.delete()..where((tbl) => tbl.id.equals(id))).go();
  }

  /// Обновить позицию HomeApp
  Future<void> updateHomeAppPosition(int id, int newPosition) async {
    await (_db.homeApps.update()..where((tbl) => tbl.id.equals(id)))
        .write(HomeAppsCompanion(position: Value(newPosition)));
  }

  /// Получить следующую позицию для нового элемента
  Future<int> _getNextPosition() async {
    final apps = await (_db.homeApps.select()
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.position)]))
        .get();
    final lastPosition = apps.isNotEmpty ? apps.last : null;
    return (lastPosition?.position ?? 0) + 1;
  }
}

/// Модель для объединённых данных HomeApp и App
class HomeAppWithDetails {
  final int id;
  final int position;
  final App app;

  HomeAppWithDetails(
      {required this.id, required this.position, required this.app});
}
