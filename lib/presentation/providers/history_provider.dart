import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masra_al_dokhail/domain/entities/history_state.dart';
import 'package:masra_al_dokhail/domain/entities/canvas_state.dart';
import 'package:masra_al_dokhail/core/constants/app_constants.dart';

final historyStateProvider = StateNotifierProvider<
    HistoryStateNotifier,
    HistoryState>((ref) {
  return HistoryStateNotifier();
});

class HistoryStateNotifier extends StateNotifier<HistoryState> {
  HistoryStateNotifier() : super(const HistoryState());

  void addState(CanvasState state) {
    var undoStack = [...state.undoStack];

    if (undoStack.length >= AppConstants.maxHistorySteps) {
      undoStack.removeAt(0);
    }

    undoStack.add(state);

    this.state = HistoryState(
      undoStack: undoStack,
      redoStack: const [],
    );
  }

  CanvasState? undo() {
    if (!state.canUndo) return null;

    final undoStack = [...state.undoStack];
    final redoStack = [...state.redoStack];

    final previousState = undoStack.removeLast();
    if (state.undoStack.isNotEmpty) {
      redoStack.add(state.undoStack.last);
    }

    this.state = HistoryState(
      undoStack: undoStack,
      redoStack: redoStack,
    );

    return previousState;
  }

  CanvasState? redo() {
    if (!state.canRedo) return null;

    final redoStack = [...state.redoStack];
    final nextState = redoStack.removeLast();

    this.state = HistoryState(
      undoStack: [...state.undoStack, nextState],
      redoStack: redoStack,
    );

    return nextState;
  }

  void clear() {
    state = const HistoryState();
  }
}
