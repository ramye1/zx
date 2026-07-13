dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masra_al_dokhail/domain/entities/canvas_state.dart';
import 'package:masra_al_dokhail/presentation/providers/canvas_provider.dart';
import 'package:masra_al_dokhail/presentation/providers/selection_provider.dart';
import 'package:masra_al_dokhail/presentation/providers/transform_provider.dart';
import 'canvas_painter.dart';

class CanvasWidget extends ConsumerStatefulWidget {
  const CanvasWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<CanvasWidget> createState() => _CanvasWidgetState();
}

class _CanvasWidgetState extends ConsumerState<CanvasWidget> {
  late Offset _lastPanPosition;

  @override
  Widget build(BuildContext context) {
    final canvasState = ref.watch(canvasStateProvider);

    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      child: GestureDetector(
        onTapDown: (details) => _handleTapDown(details, canvasState),
        onPanStart: (details) => _handlePanStart(details),
        onPanUpdate: (details) => _handlePanUpdate(details, canvasState),
        onPanEnd: (details) => _handlePanEnd(),
        child: CustomPaint(
          painter: CanvasPainter(
            elements: canvasState.elements,
            showGrid: canvasState.showGrid,
            panOffset: canvasState.panOffset,
            zoom: canvasState.zoom,
          ),
          isComplex: true,
          willChange: true,
          child: Container(color: Colors.transparent),
        ),
      ),
    );
  }

  void _handleTapDown(TapDownDetails details, CanvasState canvasState) {
    final tapPosition = details.localPosition;
    final tappedElement = canvasState.getElementAt(tapPosition);

    if (tappedElement != null) {
      ref
          .read(selectionStateProvider.notifier)
          .selectElement(tappedElement, multiSelect: false);
      _startMoveTransform(tapPosition);
    } else {
      ref.read(selectionStateProvider.notifier).clearSelection();
    }
  }

  void _startMoveTransform(Offset position) {
    ref.read(transformStateProvider.notifier).startMove(position);
  }

  void _handlePanStart(DragStartDetails details) {
    _lastPanPosition = details.localPosition;
  }

  void _handlePanUpdate(DragUpdateDetails details, CanvasState canvasState) {
    final transformState = ref.read(transformStateProvider);
    final selectionState = ref.read(selectionStateProvider);

    if (transformState.isTransforming && selectionState.hasSelection) {
      final delta = details.localPosition - _lastPanPosition;
      _applyTransform(delta, canvasState, selectionState);
      _lastPanPosition = details.localPosition;
    }
  }

  void _applyTransform(
    Offset delta,
    CanvasState canvasState,
    SelectionState selectionState,
  ) {
    for (final element in selectionState.selectedElements) {
      final updatedElement = element.copyWith(
        position: element.position + delta,
      );
      ref.read(canvasStateProvider.notifier).updateElement(updatedElement);
    }
  }

  void _handlePanEnd() {
    ref.read(transformStateProvider.notifier).endTransform();
  }
}

