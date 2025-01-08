import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:lakely/domain/entity/apps.dart';
import 'package:lakely/domain/service/apps_service.dart';

// Абстрактное состояние приложения
abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object?> get props => [];
}

// Начальное состояние
class InitialAppState extends AppState {
  const InitialAppState();
}

// Состояние загрузки
class LoadingAppState extends AppState {
  const LoadingAppState();
}

// Состояние с данными
class LoadedAppState extends AppState {
  final List<App> apps;

  const LoadedAppState(this.apps);

  @override
  List<Object?> get props => [apps];
}

// Состояние ошибки
class ErrorAppState extends AppState {
  final String errorMessage;

  const ErrorAppState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

// Cubit для управления состоянием
class AppCubit extends Cubit<AppState> {
  final AppsService _appsService;

  AppCubit(this._appsService) : super(const InitialAppState());

  // Инициализация приложения
  Future<void> init() async {
    emit(const LoadingAppState());
    try {
      await fetchApps(); // Загружаем данные из базы данных
      final installedApps = await _getInstalledApps(); // Получаем установленные приложения
      await _updateDatabase(installedApps); // Обновляем базу данных
      await fetchApps(); // Обновляем состояние с новыми данными
    } catch (e) {
      emit(ErrorAppState(e.toString()));
    }
  }

  // Загрузка приложений из базы данных
  Future<void> fetchApps() async {
    emit(const LoadingAppState());
    try {
      final apps = _appsService.getAllApps();
      emit(LoadedAppState(apps));
    } catch (e) {
      emit(ErrorAppState(e.toString()));
    }
  }

  // Получение списка установленных приложений
  Future<List<Map<String, dynamic>>> _getInstalledApps() async {
    final installedApps = await InstalledApps.getInstalledApps(false, false);
    return installedApps
        .where((app) => app.icon != null)
        .map((app) => {
      'title': app.name,
      'packageName': app.packageName,
    })
        .toList();
  }

  // Обновление базы данных
  Future<void> _updateDatabase(List<Map<String, dynamic>> apps) async {
    final packageNames = apps.map((app) => app['packageName'] as String).toSet();

    // Добавляем или обновляем приложения
    for (var app in apps) {
      final existingApps = _appsService.searchAppsByPackageName(app['packageName']);
      if (existingApps.isEmpty) {
        _appsService.addOrUpdateApp(App(
          title: app['title'] as String,
          packageName: app['packageName'] as String,
        ));
      }
    }

    // Удаляем приложения, отсутствующие в списке
    _appsService.deleteMissingApps(packageNames);
  }

  // Удаление приложения
  Future<void> deleteApp(int id) async {
    try {
      _appsService.deleteApp(id);
      await fetchApps();
    } catch (e) {
      emit(ErrorAppState(e.toString()));
    }
  }
}
