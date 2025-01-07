import 'dart:ui';

abstract class AppColors {
  Color get background;
  Color get primary;
  Color get textColor;
  Color get cardColor;
}

class _DarkColors extends AppColors {
  @override
  Color get background => Color(0xFF0F0F0F);

  @override
  Color get cardColor => Color(0xFF2F3B3D);

  @override
  Color get primary => Color(0xff008D8F);

  @override
  Color get textColor => Color(0xFFFCFCFC);
}

class _LightColors extends AppColors {
  @override
  Color get background => Color(0xFF0F0F0F);

  @override
  Color get cardColor => Color(0xFF2F3B3D);

  @override
  Color get primary => Color(0xff008D8F);

  @override
  Color get textColor => Color(0xFFFCFCFC);
}

class AppSettings {

  static final colors = _DarkColors();
}