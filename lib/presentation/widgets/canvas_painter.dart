dart
import 'package:flutter/material.dart';
import 'package:masra_al_dokhail/domain/entities/tree_element.dart';
import 'package:masra_al_dokhail/domain/entities/trunk.dart';
import 'package:masra_al_dokhail/domain/entities/branch.dart';
import 'package:masra_al_dokhail/domain/entities/leaf.dart';
import 'package:masra_al_dokhail/core/constants/app_constants.dart';

class CanvasPainter extends CustomPainter {
  final List<TreeElement> elements;
  final bool showGrid;
  final double gridSize;
  final Offset panOffset;
  final double zoom;

  CanvasPainter({
    required this.elements,
    required this.showGrid,
    this.gridSize = AppConstants.gridSize,
    this.panOffset = const Offset(0, 0),
    this.zoom = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = AppConstants.canvasBackgroundColor,
    );

    // Draw grid
    if (showGrid) {
      _drawGrid(canvas, size);
    }

    // Apply transformations
    canvas.translate(panOffset.dx, panOffset.dy);
    canvas.scale(zoom);

    // Draw elements
    for (final element in elements) {
      _drawElement(canvas, element);
    }
  }

  void _drawGrid(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppConstants.gridColor
      ..strokeWidth = 0.5;

    // Vertical lines
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      x += gridSize;
    }

    // Horizontal lines
    double y = 0;
    while (y < size.height) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      y += gridSize;
    }
  }

  void _drawElement(Canvas canvas, TreeElement element) {
    canvas.save();

    // Translate to element position
    canvas.translate(element.position.dx, element.position.dy);

    // Rotate around center
    final centerX = element.size.width / 2;
    final centerY = element.size.height / 2;
    canvas.translate(centerX, centerY);
    canvas.rotate(element.rotation);
    canvas.translate(-centerX, -centerY);

    // Draw element based on type
    if (element is Trunk) {
      _drawTrunk(canvas, element);
    } else if (element is Branch) {
      _drawBranch(canvas, element);
    } else if (element is Leaf) {
      _drawLeaf(canvas, element);
    }

    // Draw selection border if selected
    if (element.isSelected) {
      _drawSelectionBorder(canvas, element);
    }

    canvas.restore();
  }

  void _drawTrunk(Canvas canvas, Trunk trunk) {
    final rect = Rect.fromLTWH(0, 0, trunk.size.width, trunk.size.height);
    final paint = Paint()..color = trunk.color;

    canvas.drawRect(rect, paint);
  }

  void _drawBranch(Canvas canvas, Branch branch) {
    final rect = Rect.fromLTWH(0, 0, branch.size.width, branch.size.height);
    final paint = Paint()..color = branch.color;

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(4)),
      paint,
    );
  }

  void _drawLeaf(Canvas canvas, Leaf leaf) {
    final center = Offset(leaf.size.width / 2, leaf.size.height / 2);
    final radius = leaf.size.width / 2;
    final paint = Paint()..color = leaf.color;

    canvas.drawCircle(center, radius, paint);
  }

  void _drawSelectionBorder(Canvas canvas, TreeElement element) {
    final rect = Rect.fromLTWH(0, 0, element.size.width, element.size.height);
    final paint = Paint()
      ..color = AppConstants.selectionBorderColor
      ..strokeWidth = AppConstants.selectionBorderWidth
      ..style = PaintingStyle.stroke;

    canvas.drawRect(rect, paint);

    // Draw handles
    _drawSelectionHandles(canvas, element);
  }

  void _drawSelectionHandles(Canvas canvas, TreeElement element) {
    final handlePaint = Paint()..color = AppConstants.selectionBorderColor;
    final size = AppConstants.handleSize;

    // Corner handles
    final corners = [
      Offset(0, 0),
      Offset(element.size.width, 0),
      Offset(element.size.width, element.size.height),
      Offset(0, element.size.height),
    ];

    for (final corner in corners) {
      canvas.drawRect(
        Rect.fromCenter(
          center: corner,
          width: size,
          height: size,
        ),
        handlePaint,
      );
    }
  }

  @override
  bool shouldRepaint(CanvasPainter oldDelegate) {
    return oldDelegate.elements != elements ||
        oldDelegate.showGrid != showGrid ||
        oldDelegate.panOffset != panOffset ||
        oldDelegate.zoom != zoom;
  }
}
