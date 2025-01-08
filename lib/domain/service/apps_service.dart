import 'package:lakely/domain/entity/apps.dart';
import 'package:lakely/objectbox.g.dart';

class AppsService {
  final Store _store;

  AppsService(this._store);

  /// Получить все приложения
  List<App> getAllApps() {
    final box = _store.box<App>();
    return box.getAll();
  }

  /// Получить приложение по ID
  App? getAppById(int id) {
    final box = _store.box<App>();
    return box.get(id);
  }

  /// Поиск приложения по имени пакета
  List<App> searchAppsByPackageName(String packageName) {
    final box = _store.box<App>();
    final query = box.query(App_.packageName.equals(packageName)).build();
    return query.find();
  }

  /// Добавить новое приложение
  int insertApp(App app) {
    final box = _store.box<App>();
    return box.put(app); // Возвращает ID вставленного объекта
  }

  /// Обновить существующее приложение
  bool updateApp(App updatedApp) {
    final box = _store.box<App>();
    return box.put(updatedApp) > 0; // Обновляем объект (по ID)
  }

  /// Удалить приложение по ID
  bool deleteApp(int id) {
    final box = _store.box<App>();
    return box.remove(id); // Возвращает true, если объект удалён
  }

  /// Проверить существование записи по имени пакета
  bool isAppExists(String packageName) {
    final box = _store.box<App>();
    final query = box.query(App_.packageName.equals(packageName)).build();
    final exists = query.count() > 0;
    query.close();
    return exists;
  }

  /// Добавить или обновить приложение
  void addOrUpdateApp(App app) {
    final box = _store.box<App>();
    box.put(app); // ObjectBox автоматически обновит объект, если он существует
  }

  /// Удалить приложения, отсутствующие в списке packageNames
  void deleteMissingApps(Set<String> existingPackageNames) {
    final box = _store.box<App>();

    // Создаём запрос, чтобы получить все записи
    final query = box.query().build();
    final apps = query.find(); // Получаем все записи

    // Находим приложения, packageName которых отсутствует в existingPackageNames
    final appsToDelete = apps.where((app) => !existingPackageNames.contains(app.packageName)).toList();

    // Удаляем найденные приложения
    box.removeMany(appsToDelete.map((app) => app.id).toList());
  }
}
