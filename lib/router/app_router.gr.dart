// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AppsScreen]
class AppsRoute extends PageRouteInfo<void> {
  const AppsRoute({List<PageRouteInfo>? children})
      : super(
          AppsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppsScreen();
    },
  );
}

/// generated route for
/// [EditNoteScreen]
class EditNoteRoute extends PageRouteInfo<EditNoteRouteArgs> {
  EditNoteRoute({
    Key? key,
    int? id,
    List<PageRouteInfo>? children,
  }) : super(
          EditNoteRoute.name,
          args: EditNoteRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'EditNoteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditNoteRouteArgs>(
          orElse: () => const EditNoteRouteArgs());
      return EditNoteScreen(
        key: args.key,
        id: args.id,
      );
    },
  );
}

class EditNoteRouteArgs {
  const EditNoteRouteArgs({
    this.key,
    this.id,
  });

  final Key? key;

  final int? id;

  @override
  String toString() {
    return 'EditNoteRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainScreen();
    },
  );
}

/// generated route for
/// [RootScreen]
class RootRoute extends PageRouteInfo<void> {
  const RootRoute({List<PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RootScreen();
    },
  );
}

/// generated route for
/// [WorkScreen]
class WorkRoute extends PageRouteInfo<void> {
  const WorkRoute({List<PageRouteInfo>? children})
      : super(
          WorkRoute.name,
          initialChildren: children,
        );

  static const String name = 'WorkRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const WorkScreen();
    },
  );
}
