import 'package:auto_route/auto_route.dart';
import 'package:lakely/presentation/screens/apps/apps_screen.dart';
import 'package:lakely/presentation/screens/main/main_screen.dart';
import 'package:lakely/presentation/screens/root/root_screen.dart';
import 'package:lakely/presentation/screens/work/work_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: RootRoute.page,
          children: [
            RedirectRoute(path: '', redirectTo: 'main'),
            AutoRoute(path: 'main', page: MainRoute.page),
            AutoRoute(path: 'work', page: WorkRoute.page),
            AutoRoute(path: 'apps', page: AppsRoute.page),
          ],
        ),
      ];
}