dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masra_al_dokhail/core/utils/id_generator.dart';
import 'package:masra_al_dokhail/domain/entities/trunk.dart';
import 'package:masra_al_dokhail/domain/entities/branch.dart';
import 'package:masra_al_dokhail/domain/entities/leaf.dart';
import 'package:masra_al_dokhail/presentation/providers/canvas_provider.dart';
import 'package:masra_al_dokhail/presentation/providers/selection_provider.dart';

class ToolbarWidget extends ConsumerWidget {
  const ToolbarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectionState = ref.watch(selectionStateProvider);
    final canvasState = ref.watch(canvasStateProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'أدوات',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _ElementButton(
              label: 'إضافة جذع',
              onPressed: () {
                final trunk = Trunk(
                  id: IdGenerator.generateWithPrefix('trunk'),
                  position: const Offset(300, 300),
                );
                ref.read(canvasStateProvider.notifier).addElement(trunk);
              },
            ),
            const SizedBox(height: 8),
            _ElementButton(
              label: 'إضافة غصن',
              onPressed: () {
                final branch = Branch(
                  id: IdGenerator.generateWithPrefix('branch'),
                  position: const Offset(400, 400),
                );
                ref.read(canvasStateProvider.notifier).addElement(branch);
              },
            ),
            const SizedBox(height: 8),
            _ElementButton(
              label: 'إضافة ورقة',
              onPressed: () {
                final leaf = Leaf(
                  id: IdGenerator.generateWithPrefix('leaf'),
                  position: const Offset(500, 500),
                );
                ref.read(canvasStateProvider.notifier).addElement(leaf);
              },
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            _ActionButton(
              label: 'حذف',
              onPressed: selectionState.hasSelection
                  ? () {
                      for (final element in selectionState.selectedElements) {
                        ref
                            .read(canvasStateProvider.notifier)
                            .removeElement(element.id);
                      }
                      ref.read(selectionStateProvider.notifier).clearSelection();
                    }
                  : null,
            ),
            const SizedBox(height: 8),
            _ActionButton(
              label: 'مسح الرسم',
              onPressed: canvasState.elements.isNotEmpty
                  ? () => _showClearConfirmation(context, ref)
                  : null,
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              'العناصر المختارة: ${selectionState.selectedElements.length}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              'إجمالي العناصر: ${canvasState.elements.length}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  void _showClearConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: const Text('هل تريد حذف جميع العناصر من الرسم؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              ref.read(canvasStateProvider.notifier).clearCanvas();
              ref.read(selectionStateProvider.notifier).clearSelection();
              Navigator.pop(context);
            },
            child: const Text('تأكيد', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _ElementButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _ElementButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Text(label),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _ActionButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        backgroundColor: Colors.red[400],
        disabledBackgroundColor: Colors.grey[300],
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
