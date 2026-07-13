import 'package:flutter/material.dart';

class AppConstants {
  // Canvas
  static const double defaultCanvasWidth = 1200.0;
  static const double defaultCanvasHeight = 800.0;
  static const double canvasBorderWidth = 1.0;
  static const Color canvasBorderColor = Color(0xFFE0E0E0);
  static const Color canvasBackgroundColor = Color(0xFFFAFAFA);

  // Elements
  static const double trunkDefaultWidth = 60.0;
  static const double trunkDefaultHeight = 100.0;
  static const Color trunkDefaultColor = Color(0xFF8B4513);

  static const double branchDefaultWidth = 80.0;
  static const double branchDefaultHeight = 40.0;
  static const Color branchDefaultColor = Color(0xFF228B22);

  static const double leafDefaultWidth = 50.0;
  static const double leafDefaultHeight = 50.0;
  static const Color leafDefaultColor = Color(0xFF90EE90);

  // Selection
  static const double selectionBorderWidth = 2.0;
  static const Color selectionBorderColor = Color(0xFF2196F3);
  static const double handleSize = 8.0;

  // Transform
  static const double minScale = 0.1;
  static const double maxScale = 5.0;
  static const double rotationSnapAngle = 5.0;

  // History
  static const int maxHistorySteps = 100;

  // Grid
  static const double gridSize = 20.0;
  static const Color gridColor = Color(0xFFEEEEEE);

  // Animation
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // Spacing
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
}
