import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lakely/presentation/components/clock_widget.dart';
import 'package:lakely/presentation/components/home_apps_list.dart';
import 'package:lakely/utils/app_colors.dart';
import 'package:lakely/utils/launch_apps.dart';
import 'package:lakely/utils/status_and_navigation_bar_color.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // setUiModeFullScreenImmersiveSticky();
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppSettings.colors.background,
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 92,
                    ),
                    SizedBox(width: double.infinity, child: ClockWidget()),
                    SizedBox(height: 56,),
                    ElevatedButton(onPressed: launchGoogle, child: Text("Поиск в Goggle")),
                    SizedBox(height: 86,),
                    HomeAppsList()
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(onPressed: launchPhone, icon: Icon(Icons.phone_rounded, size: 36,)),
                IconButton(onPressed: launchCamera, icon: Icon(Icons.camera_alt_rounded, size: 36)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
