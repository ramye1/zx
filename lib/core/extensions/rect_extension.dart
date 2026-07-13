
import 'package:flutter/material.dart';

extension RectExtension on Rect {
  bool containsPoint(Offset point) {
    return left <= point.dx &&
        point.dx <= right &&
        top <= point.dy &&
        point.dy <= bottom;
  }

  bool intersects(Rect other) {
    return !(right < other.left ||
        other.right < left ||
        bottom < other.top ||
        other.bottom < top);
  }

  Rect expandByDistance(double distance) {
    return Rect.fromLTRB(
      left - distance,
      top - distance,
      right + distance,
      bottom + distance,
    );
  }

  Offset get center => Offset(left + width / 2, top + height / 2);

  Rect translate(Offset offset) {
    return Rect.fromLTRB(
      left + offset.dx,
      top + offset.dy,
      right + offset.dx,
      bottom + offset.dy,
    );
  }
}
