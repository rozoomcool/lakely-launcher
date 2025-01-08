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
        throw StateError(
            "Связанное приложение не найдено для HomeApp ID ${homeApp.id}");
      }
    }).toList();
  }

  List<HomeApp> getAll() {
    final homeAppBox = _store.box<HomeApp>();
    return homeAppBox.getAll();
  }

  void reorder(int oldIndex, int newIndex) {
    normalizePositions();
    final homeAppBox = _store.box<HomeApp>();

    // Получаем элемент, который нужно переместить
    final movingApp = homeAppBox
        .query(HomeApp_.position.equals(oldIndex))
        .build()
        .findFirst();

    if (movingApp == null) return; // Если элемент не найден, выходим

    // Если позиция не изменилась, ничего не делаем
    if (oldIndex == newIndex) return;

    // Создаём транзакцию для атомарного обновления
    _store.runInTransaction(TxMode.write, () {
      if (oldIndex < newIndex) {
        // Сдвигаем элементы между oldIndex и newIndex на -1
        final affectedApps = homeAppBox
            .query(HomeApp_.position.between(oldIndex + 1, newIndex))
            .build()
            .find();

        for (var app in affectedApps) {
          app.position -= 1;
          homeAppBox.put(app, mode: PutMode.update);
        }
      } else {
        // Сдвигаем элементы между newIndex и oldIndex на +1
        final affectedApps = homeAppBox
            .query(HomeApp_.position.between(newIndex, oldIndex - 1))
            .build()
            .find();

        for (var app in affectedApps) {
          app.position += 1;
          homeAppBox.put(app, mode: PutMode.update);
        }
      }

      // Устанавливаем новую позицию перемещаемому элементу
      movingApp.position = newIndex;
      homeAppBox.put(movingApp, mode: PutMode.update);
    });
  }

  void normalizePositions() {
    final homeAppBox = _store.box<HomeApp>();
    final apps = homeAppBox.query().order(HomeApp_.position).build().find();

    for (int i = 0; i < apps.length; i++) {
      apps[i].position = i;
      homeAppBox.put(apps[i], mode: PutMode.update);
    }
  }

  void deleteByAppId(int appId) {
    final homeAppBox = _store.box<HomeApp>();
    homeAppBox.query(HomeApp_.app.equals(appId)).build().remove();
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
    normalizePositions();
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

    return (lastHomeApp?.position ?? -1) + 1;
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
