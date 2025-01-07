import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lakely/domain/db/database.dart';
import 'package:lakely/domain/service/home_apps_service.dart';

// Абстрактное состояние HomeApps
abstract class HomeAppsState extends Equatable {
  const HomeAppsState();

  @override
  List<Object?> get props => [];
}

// Начальное состояние
class InitialHomeAppsState extends HomeAppsState {
  const InitialHomeAppsState();
}

// Состояние загрузки
class LoadingHomeAppsState extends HomeAppsState {
  const LoadingHomeAppsState();
}

// Состояние с данными
class LoadedHomeAppsState extends HomeAppsState {
  final List<HomeAppWithDetails> homeApps;

  const LoadedHomeAppsState(this.homeApps);

  @override
  List<Object?> get props => [homeApps];
}

// Состояние ошибки
class ErrorHomeAppsState extends HomeAppsState {
  final String errorMessage;

  const ErrorHomeAppsState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

// Cubit для управления состоянием HomeApps
class HomeAppsCubit extends Cubit<HomeAppsState> {
  final HomeAppsService _homeAppsService;

  HomeAppsCubit(this._homeAppsService) : super(const InitialHomeAppsState());

  void init() {
    fetchHomeApps();
  }

  // Загрузка всех HomeApps
  Future<void> fetchHomeApps() async {
    emit(const LoadingHomeAppsState());
    try {
      final homeApps = await _homeAppsService.getAllHomeAppsWithDetails();
      emit(LoadedHomeAppsState(homeApps));
    } catch (e) {
      emit(ErrorHomeAppsState(e.toString()));
    }
  }

  // Добавление HomeApp
  Future<void> addHomeApp(int appId) async {
    try {
      await _homeAppsService.addHomeApp(appId);
      await fetchHomeApps();
    } catch (e) {
      emit(ErrorHomeAppsState(e.toString()));
    }
  }

  // Удаление HomeApp
  Future<void> deleteHomeApp(int id) async {
    try {
      await _homeAppsService.deleteHomeApp(id);
      await fetchHomeApps();
    } catch (e) {
      emit(ErrorHomeAppsState(e.toString()));
    }
  }

  // Обновление позиции HomeApp
  Future<void> updateHomeAppPosition(int id, int newPosition) async {
    try {
      await _homeAppsService.updateHomeAppPosition(id, newPosition);
      await fetchHomeApps();
    } catch (e) {
      emit(ErrorHomeAppsState(e.toString()));
    }
  }
}
