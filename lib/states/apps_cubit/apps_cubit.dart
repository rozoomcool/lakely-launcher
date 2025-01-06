import 'dart:typed_data';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:lakely/domain/db/database.dart';

// Состояние приложения
class AppState extends Equatable {
  final List<App> apps;
  final bool isLoading;
  final String? errorMessage;

  const AppState({
    this.apps = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  AppState copyWith({
    List<App>? apps,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AppState(
      apps: apps ?? this.apps,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [apps, isLoading, errorMessage];
}

// Cubit для управления состоянием
class AppCubit extends Cubit<AppState> {
  final AppDatabase _db;

  AppCubit(this._db) : super(const AppState());

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));
    await fetchApps(); // Загрузка из базы данных

    try {
      final installedApps = await _getInstalledApps(); // Синхронизация
      await _updateDatabase(installedApps); // Обновление базы данных
      await fetchApps(); // Обновление UI
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  // Загрузка приложений из базы данных
  Future<void> fetchApps() async {
    emit(state.copyWith(isLoading: true));
    try {
      final apps = await _db.apps.select().get();
      emit(state.copyWith(apps: apps, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  // Получение списка установленных приложений
  Future<List<Map<String, dynamic>>> _getInstalledApps() async {
    final installedApps = await InstalledApps.getInstalledApps(false, true);
    return installedApps
        .where((app) => app.icon != null)
        .map((app) => {
      'title': app.name,
      'packageName': app.packageName,
      'icon': app.icon,
    })
        .toList();
  }

  // Обновление базы данных
  Future<void> _updateDatabase(List<Map<String, dynamic>> apps) async {
    final existingApps = await _db.apps.select().get();
    final existingPackageNames =
    existingApps.map((app) => app.packageName).toSet();

    // Добавляем или обновляем приложения
    for (var app in apps) {
      if (!existingPackageNames.contains(app['packageName'])) {
        await _db.apps.insertOnConflictUpdate(
          AppsCompanion.insert(
            title: app['title'] as String,
            packageName: app['packageName'] as String,
            icon: app['icon'] as Uint8List,
          ),
        );
      }
    }

    // Удаляем приложения, которых больше нет
    final newPackageNames =
    apps.map((app) => app['packageName'] as String).toSet();
    final appsToDelete =
    existingPackageNames.difference(newPackageNames).toList();

    for (var packageName in appsToDelete) {
      await _db.apps.deleteWhere((tbl) => tbl.packageName.equals(packageName));
    }
  }

  // Удаление приложения
  Future<void> deleteApp(int id) async {
    try {
      await _db.apps.deleteWhere((tbl) => tbl.id.equals(id));
      await fetchApps();
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
