dart
import 'package:flutter/material.dart';

extension OffsetExtension on Offset {
  Offset rotateAround(Offset center, double angle) {
    final cos = math.cos(angle);
    final sin = math.sin(angle);
    final x = this.dx - center.dx;
    final y = this.dy - center.dy;
    return Offset(
      center.dx + x * cos - y * sin,
      center.dy + x * sin + y * cos,
    );
  }

  double distanceTo(Offset other) {
    return ((this - other).distance);
  }

  Offset lerp(Offset other, double t) {
    return Offset.lerp(this, other, t) ?? this;
  }
}

import 'dart:math' as math;
