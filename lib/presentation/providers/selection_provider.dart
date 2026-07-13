dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masra_al_dokhail/domain/entities/selection_state.dart';
import 'package:masra_al_dokhail/domain/entities/tree_element.dart';
import 'package:flutter/material.dart';

final selectionStateProvider = StateNotifierProvider<
    SelectionStateNotifier,
    SelectionState>((ref) {
  return SelectionStateNotifier();
});

class SelectionStateNotifier extends StateNotifier<SelectionState> {
  SelectionStateNotifier() : super(const SelectionState());

  void selectElement(TreeElement element, {bool multiSelect = false}) {
    if (multiSelect) {
      if (state.isElementSelected(element.id)) {
        _deselectElement(element.id);
      } else {
        _addToSelection(element);
      }
    } else {
      _clearSelection();
      _addToSelection(element);
    }
  }

  void _addToSelection(TreeElement element) {
    final updatedElements = [...state.selectedElements, element];
    final bounds = _calculateBounds(updatedElements);
    state = state.copyWith(
      selectedElements: updatedElements,
      selectionBounds: bounds,
    );
  }

  void _deselectElement(String elementId) {
    final updatedElements =
        state.selectedElements.where((e) => e.id != elementId).toList();
    final bounds = updatedElements.isEmpty ? null : _calculateBounds(updatedElements);
    state = state.copyWith(
      selectedElements: updatedElements,
      selectionBounds: bounds,
    );
  }

  void clearSelection() {
    _clearSelection();
  }

  void _clearSelection() {
    state = const SelectionState();
  }

  void selectInRect(List<TreeElement> allElements, Rect selectionRect) {
    final selected = allElements
        .where((e) => selectionRect.intersects(e.bounds))
        .toList();

    if (selected.isEmpty) {
      _clearSelection();
    } else {
      final bounds = _calculateBounds(selected);
      state = state.copyWith(
        selectedElements: selected,
        selectionBounds: bounds,
      );
    }
  }

  Rect? _calculateBounds(List<TreeElement> elements) {
    if (elements.isEmpty) return null;

    double left = elements.first.bounds.left;
    double top = elements.first.bounds.top;
    double right = elements.first.bounds.right;
    double bottom = elements.first.bounds.bottom;

    for (final element in elements.skip(1)) {
      final bounds = element.bounds;
      left = left > bounds.left ? bounds.left : left;
      top = top > bounds.top ? bounds.top : top;
      right = right < bounds.right ? bounds.right : right;
      bottom = bottom < bounds.bottom ? bounds.bottom : bottom;
    }

    return Rect.fromLTRB(left, top, right, bottom);
  }
}
