import 'dart:typed_data';

import 'package:installed_apps/installed_apps.dart';

class AppIconCacheUtil {
  static final Map<String, Uint8List> _cache = {};

  static Future<Uint8List?> getIcon(String packageName) async {
    if (_cache.containsKey(packageName)) {
      return _cache[packageName];
    }
    final appInfo = await InstalledApps.getAppInfo(packageName);
    if (appInfo?.icon != null) {
      _cache[packageName] = appInfo!.icon!;
      return appInfo.icon!;
    }
    return null;
  }

}