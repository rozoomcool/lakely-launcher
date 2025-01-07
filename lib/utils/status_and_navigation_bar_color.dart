import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

// void darkStatusAndNavigationBar() {
//   SystemChrome.setSystemUIOverlayStyle(
//     SystemUiOverlayStyle(
//       statusBarBrightness: Brightness.dark,
//       statusBarColor: AppSettings.colors.background,
//       statusBarIconBrightness: Brightness.light,
//       systemNavigationBarColor: AppSettings.colors.background,
//       systemNavigationBarDividerColor: AppSettings.colors.background,
//       systemNavigationBarIconBrightness: Brightness.dark,
//     ),
//   );
// }
void darkStatusAndNavigationBar() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      // statusBarColor: AppSettings.colors.background,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppSettings.colors.background,
      // systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: AppSettings.colors.background,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
      overlays: [ SystemUiOverlay.top ]
  );
}

void lightStatusAndNavigationBar() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}