import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lakely/router/app_router.dart';
import 'package:lakely/utils/status_and_navigation_bar_color.dart';

@RoutePage()
class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.pageView(
      routes: [
        WorkRoute(),
        MainRoute(),
        AppsRoute(),
      ],
      builder: (context, child, _) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
        );
      },
    );
  }
}
