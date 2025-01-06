import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lakely/domain/db/database.dart';

// Состояние HomeApps
class HomeAppsState extends Equatable {
  final List<HomeApp> homeApps;
  final bool isLoading;
  final String? errorMessage;

  const HomeAppsState({
    this.homeApps = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  HomeAppsState copyWith({
    List<HomeApp>? homeApps,
    bool? isLoading,
    String? errorMessage,
  }) {
    return HomeAppsState(
      homeApps: homeApps ?? this.homeApps,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [homeApps, isLoading, errorMessage];
}

// Cubit для управления состоянием HomeApps
class HomeAppsCubit extends Cubit<HomeAppsState> {
  final AppDatabase _db;

  HomeAppsCubit(this._db) : super(const HomeAppsState());

  // Загрузка всех HomeApps
  Future<void> fetchHomeApps() async {
    emit(state.copyWith(isLoading: true));
    try {
      final homeApps = await _db.homeApps.select().get();
      emit(state.copyWith(homeApps: homeApps, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  // Добавление HomeApp
  Future<void> addHomeApp(HomeAppsCompanion homeApp) async {
    try {
      await _db.homeApps.insertOnConflictUpdate(homeApp);
      await fetchHomeApps();
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  // Удаление HomeApp
  Future<void> deleteHomeApp(int id) async {
    try {
      await _db.homeApps.deleteWhere((tbl) => tbl.id.equals(id));
      await fetchHomeApps();
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  // Обновление позиции HomeApp
  Future<void> updateHomeAppPosition(int id, int newPosition) async {
    try {
      await (_db.homeApps.update()
        ..where((tbl) => tbl.id.equals(id)))
          .write(HomeAppsCompanion(position: Value(newPosition)));
      await fetchHomeApps();
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}