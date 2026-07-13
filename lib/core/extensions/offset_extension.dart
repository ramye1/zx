dart
import 'package:flutter/material.dart';
import 'dart:math' as math;

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
}
