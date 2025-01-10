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
      // statusBarBrightness: Brightness.dark,
      // statusBarColor: AppSettings.colors.background,
      // // statusBarColor: Colors.transparent,
      // statusBarIconBrightness: Brightness.light,
      // systemNavigationBarColor: AppSettings.colors.background,
      systemNavigationBarColor: Colors.transparent,
      // systemNavigationBarDividerColor: AppSettings.colors.background,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarContrastEnforced: false,
      systemStatusBarContrastEnforced: false
    ),
  );
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}

// void setUiModeFullScreenManual() {
//   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//       overlays: [SystemUiOverlay.top]);
// }
//
// void setUiModeFullScreenImmersiveSticky() {
//   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//       overlays: [SystemUiOverlay.top]
//   );
// }

// void lightStatusAndNavigationBar() {
//   SystemChrome.setSystemUIOverlayStyle(
//     SystemUiOverlayStyle(
//       statusBarBrightness: Brightness.dark,
//       statusBarColor: Colors.white,
//       statusBarIconBrightness: Brightness.dark,
//       systemNavigationBarColor: Colors.white,
//       systemNavigationBarDividerColor: Colors.white,
//       systemNavigationBarIconBrightness: Brightness.dark,
//     ),
//   );
// }
