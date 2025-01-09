import 'package:flutter/material.dart';
import 'package:lakely/utils/app_colors.dart';

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gradient = RadialGradient(
      colors: [Colors.grey.withAlpha(10), Colors.grey.withAlpha(5)],
    );

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = 1.5;

    final background = Paint()..color = AppSettings.colors.background;

    const gridSize = 20.0;

    canvas.drawRect(
        Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height)),
        background);

    // Рисуем вертикальные линии
    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Рисуем горизонтальные линии
    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
