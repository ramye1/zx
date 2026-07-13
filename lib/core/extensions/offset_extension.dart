import 'dart:math' as math;
import 'package:flutter/material.dart';

extension OffsetExtension on Offset {
  Offset rotateAround(Offset center, double angle) {
    final cos = math.cos(angle);
    final sin = math.sin(angle);

    final x = dx - center.dx;
    final y = dy - center.dy;

    return Offset(
      center.dx + x * cos - y * sin,
      center.dy + x * sin + y * cos,
    );
  }

  double distanceTo(Offset other) {
    return (this - other).distance;
  }

  Offset lerpTo(Offset other, double t) {
    return Offset.lerp(this, other, t) ?? this;
  }

  Offset snapToGrid(double gridSize) {
    return Offset(
      (dx / gridSize).round() * gridSize,
      (dy / gridSize).round() * gridSize,
    );
  }

  bool isNear(Offset other, {double tolerance = 10.0}) {
    return distanceTo(other) <= tolerance;
  }

  Offset clampToRect(Rect rect) {
    return Offset(
      dx.clamp(rect.left, rect.right),
      dy.clamp(rect.top, rect.bottom),
    );
  }
}
