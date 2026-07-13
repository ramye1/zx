import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:masra_al_dokhail/domain/entities/transform_state.dart';

final transformStateProvider = StateNotifierProvider<
    TransformStateNotifier,
    TransformState>((ref) {
  return TransformStateNotifier();
});

class TransformStateNotifier extends StateNotifier<TransformState> {
  TransformStateNotifier() : super(const TransformState());

  void startMove(Offset position) {
    state = state.copyWith(
      mode: TransformMode.move,
      startPosition: position,
      currentPosition: position,
    );
  }

  void startResize(Offset position, Size startSize) {
    state = state.copyWith(
      mode: TransformMode.resize,
      startPosition: position,
      currentPosition: position,
      startSize: startSize,
    );
  }

  void startRotate(Offset position, double startRotation) {
    state = state.copyWith(
      mode: TransformMode.rotate,
      startPosition: position,
      currentPosition: position,
      startRotation: startRotation,
    );
  }

  void updateTransform(Offset currentPosition) {
    state = state.copyWith(currentPosition: currentPosition);
  }

  void endTransform() {
    state = const TransformState();
  }

  void reset() {
    state = const TransformState();
  }
}

