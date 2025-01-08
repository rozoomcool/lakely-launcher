import 'package:lakely/domain/entity/apps.dart';
import 'package:lakely/domain/entity/home_apps.dart';
import 'package:lakely/objectbox.g.dart';

class HomeAppsService {
  final Store _store;

  HomeAppsService(this._store);

  /// Получить все HomeApps с подгрузкой связанных приложений
  List<HomeAppWithDetails> getAllHomeAppsWithDetails() {
    final homeAppBox = _store.box<HomeApp>();

    final homeApps = homeAppBox.getAll();
    return homeApps.map((homeApp) {
      final app = homeApp.app.target; // Подгружаем связанное приложение
      if (app != null) {
        return HomeAppWithDetails(
          id: homeApp.id,
          position: homeApp.position,
          app: app,
        );
      } else {
        throw StateError("Связанное приложение не найдено для HomeApp ID ${homeApp.id}");
      }
    }).toList();
  }

  /// Добавить запись в HomeApps
  void addHomeApp(int appId) {
    final appBox = _store.box<App>();
    final homeAppBox = _store.box<HomeApp>();

    // Проверяем, существует ли приложение
    final app = appBox.get(appId);
    if (app == null) return;

    // Получаем следующую позицию
    final position = _getNextPosition();

    // Создаём HomeApp и устанавливаем связь
    final homeApp = HomeApp(position: position);
    homeApp.app.target = app;
    homeAppBox.put(homeApp);
  }

  /// Удалить запись из HomeApps
  void deleteHomeApp(int id) {
    final homeAppBox = _store.box<HomeApp>();
    homeAppBox.remove(id);
  }

  /// Обновить позицию HomeApp
  void updateHomeAppPosition(int id, int newPosition) {
    final homeAppBox = _store.box<HomeApp>();
    final homeApp = homeAppBox.get(id);
    if (homeApp != null) {
      homeApp.position = newPosition;
      homeAppBox.put(homeApp);
    }
  }

  /// Получить следующую позицию для нового элемента
  int _getNextPosition() {
    final homeAppBox = _store.box<HomeApp>();

    // Получаем последнюю позицию
    final query = homeAppBox.query()
      ..order(HomeApp_.position, flags: Order.descending);
    final lastHomeApp = query.build().findFirst();

    return (lastHomeApp?.position ?? 0) + 1;
  }
}

/// Модель для объединённых данных HomeApp и App
class HomeAppWithDetails {
  final int id;
  final int position;
  final App app;

  HomeAppWithDetails({
    required this.id,
    required this.position,
    required this.app,
  });
}
