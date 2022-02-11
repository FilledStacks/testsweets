import 'package:flutter/material.dart';
import 'package:testsweets/src/constants/app_constants.dart';

import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/widget_type_extension.dart';

class ConnectionPainter extends CustomPainter {
  final WidgetType sourcePointType;
  final Offset sourcePoint;
  final List<Offset> targetPoints;
  const ConnectionPainter({
    required this.sourcePointType,
    required this.sourcePoint,
    required this.targetPoints,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Rect.largest, Paint());

    for (var targetPoint in targetPoints) {
      final linePaint = Paint()
        ..color = sourcePointType.getColorOfWidgetType
        ..strokeWidth = 2;

      canvas.drawLine(sourcePoint, targetPoint, linePaint);
      final circlePaint = Paint()
        ..color = Colors.transparent
        ..blendMode = BlendMode.clear;
      canvas.drawCircle(
          targetPoint, WIDGET_DESCRIPTION_VISUAL_SIZE / 2, circlePaint);
    }
    final circlePaint = Paint()
      ..color = Colors.transparent
      ..blendMode = BlendMode.clear;
    canvas.drawCircle(
        sourcePoint, WIDGET_DESCRIPTION_VISUAL_SIZE / 2, circlePaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
