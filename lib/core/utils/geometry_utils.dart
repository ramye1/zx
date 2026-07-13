dart
import 'package:flutter/material.dart';
import 'dart:math' as math;

class GeometryUtils {
  static Offset rotatePoint(
    Offset point,
    Offset center,
    double angleInRadians,
  ) {
    final cos = math.cos(angleInRadians);
    final sin = math.sin(angleInRadians);
    final x = point.dx - center.dx;
    final y = point.dy - center.dy;

    return Offset(
      center.dx + x * cos - y * sin,
      center.dy + x * sin + y * cos,
    );
  }

  static double degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }

  static double radiansToDegrees(double radians) {
    return radians * 180 / math.pi;
  }

  static double snapToAngle(double angle, double snapAngle) {
    return (angle / snapAngle).round() * snapAngle;
  }

  static Rect getBoundsForMultipleElements(List<Rect> bounds) {
    if (bounds.isEmpty) return Rect.zero;

    double left = bounds.first.left;
    double top = bounds.first.top;
    double right = bounds.first.right;
    double bottom = bounds.first.bottom;

    for (final bound in bounds.skip(1)) {
      left = math.min(left, bound.left);
      top = math.min(top, bound.top);
      right = math.max(right, bound.right);
      bottom = math.max(bottom, bound.bottom);
    }

    return Rect.fromLTRB(left, top, right, bottom);
  }

  static Size constrainSize(
    Size size, {
    double minWidth = 10,
    double minHeight = 10,
    double maxWidth = 2000,
    double maxHeight = 2000,
  }) {
    return Size(
      size.width.clamp(minWidth, maxWidth),
      size.height.clamp(minHeight, maxHeight),
    );
  }
}
