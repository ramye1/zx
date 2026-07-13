import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masra_al_dokhail/domain/entities/canvas_state.dart';
import 'package:masra_al_dokhail/domain/entities/tree_element.dart';
import 'package:masra_al_dokhail/domain/repositories/canvas_repository.dart';

final canvasRepositoryProvider = Provider<CanvasRepository>((ref) {
  throw UnimplementedError('canvasRepositoryProvider must be provided');
});

final canvasStateProvider = StateNotifierProvider<
    CanvasStateNotifier,
    CanvasState>((ref) {
  final repository = ref.watch(canvasRepositoryProvider);
  return CanvasStateNotifier(repository);
});

class CanvasStateNotifier extends StateNotifier<CanvasState> {
  final CanvasRepository _repository;

  CanvasStateNotifier(this._repository) : super(const CanvasState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    final savedState = await _repository.getCanvasState();
    state = savedState;
  }

  Future<void> addElement(TreeElement element) async {
    await _repository.addElement(element);
    final updatedState = await _repository.getCanvasState();
    state = updatedState;
  }

  Future<void> removeElement(String elementId) async {
    await _repository.removeElement(elementId);
    final updatedState = await _repository.getCanvasState();
    state = updatedState;
  }

  Future<void> updateElement(TreeElement element) async {
    await _repository.updateElement(element);
    final updatedState = await _repository.getCanvasState();
    state = updatedState;
  }

  Future<void> clearCanvas() async {
    await _repository.clearCanvas();
    state = const CanvasState();
  }

  void setZoom(double zoom) {
    state = state.copyWith(zoom: zoom);
  }

  void setPanOffset(Offset offset) {
    state = state.copyWith(panOffset: offset);
  }

  void toggleGrid() {
    state = state.copyWith(showGrid: !state.showGrid);
  }
}
