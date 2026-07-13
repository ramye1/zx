dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masra_al_dokhail/presentation/providers/canvas_provider.dart';
import 'package:masra_al_dokhail/presentation/providers/selection_provider.dart';
import 'package:masra_al_dokhail/presentation/providers/transform_provider.dart';
import 'canvas_painter.dart';

class CanvasWidget extends ConsumerWidget {
  const CanvasWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canvasState = ref.watch(canvasStateProvider);
    final transformState = ref.watch(transformStateProvider);

    return GestureDetector(
      onTapDown: (details) {
        _handleTapDown(details, context, ref, canvasState);
      },
      onPanStart: (details) {
        _handlePanStart(details, ref);
      },
      onPanUpdate: (details) {
        _handlePanUpdate(details, ref, canvasState);
      },
      onPanEnd: (details) {
        _handlePanEnd(ref);
      },
      child: CustomPaint(
        painter: CanvasPainter(
          elements: canvasState.elements,
          showGrid: canvasState.showGrid,
          panOffset: canvasState.panOffset,
          zoom: canvasState.zoom,
        ),
        child: Container(
          color: Colors.transparent,
        ),
      ),
    );
  }

  void _handleTapDown(
    TapDownDetails details,
    BuildContext context,
    WidgetRef ref,
    CanvasState canvasState,
  ) {
    final tapPosition = details.localPosition;

    // Check if an element was tapped
    final tappedElement = canvasState.getElementAt(tapPosition);

    if (tappedElement != null) {
      final multiSelect = details.kind == PointerDeviceKind.mouse &&
          HardwareKeyboard.instance.isShiftPressed;
      ref
          .read(selectionStateProvider.notifier)
          .selectElement(tappedElement, multiSelect: multiSelect);
    } else {
      ref.read(selectionStateProvider.notifier).clearSelection();
    }
  }

  void _handlePanStart(PointerDownEvent details, WidgetRef ref) {
    final selectionState = ref.read(selectionStateProvider);

    if (selectionState.hasSelection) {
      ref.read(transformStateProvider.notifier).startMove(details.position);
    }
  }

  void _handlePanUpdate(
    PointerMoveEvent details,
    WidgetRef ref,
    CanvasState canvasState,
  ) {
    final transformState = ref.read(transformStateProvider);

    if (transformState.isTransforming) {
      ref.read(transformStateProvider.notifier).updateTransform(details.position);
    }
  }

  void _handlePanEnd(WidgetRef ref) {
    ref.read(transformStateProvider.notifier).endTransform();
  }
}

// Placeholder for CanvasState import
import 'package:masra_al_dokhail/domain/entities/canvas_state.dart';
