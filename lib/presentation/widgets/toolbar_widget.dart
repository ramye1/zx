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
            _buildElementButton(
              context,
              ref,
              'إضافة جذع',
              () {
                final trunk = Trunk(
                  id: IdGenerator.generateWithPrefix('trunk'),
                  position: const Offset(300, 300),
                );
                ref.read(canvasStateProvider.notifier).addElement(trunk);
              },
            ),
            const SizedBox(height: 8),
            _buildElementButton(
              context,
              ref,
              'إضافة غصن',
              () {
                final branch = Branch(
                  id: IdGenerator.generateWithPrefix('branch'),
                  position: const Offset(400, 400),
                );
                ref.read(canvasStateProvider.notifier).addElement(branch);
              },
            ),
            const SizedBox(height: 8),
            _buildElementButton(
              context,
              ref,
              'إضافة ورقة',
              () {
                final leaf = Leaf(
                  id: IdGenerator.generateWithPrefix('leaf'),
                  position: const Offset(500, 500),
                );
                ref.read(canvasStateProvider.notifier).addElement(leaf);
              },
            ),
            const SizedBox(height: 16),
            _buildActionButton(
              context,
              ref,
              'حذف',
              () {
                final selectionState = ref.read(selectionStateProvider);
                for (final element in selectionState.selectedElements) {
                  ref.read(canvasStateProvider.notifier).removeElement(element.id);
                }
                ref.read(selectionStateProvider.notifier).clearSelection();
              },
              enabled: ref.watch(selectionStateProvider).hasSelection,
            ),
            const SizedBox(height: 8),
            _buildActionButton(
              context,
              ref,
              'مسح الرسم',
              () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('تأكيد'),
                    content: const Text('هل تريد حذف جميع العناصر؟'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('إلغاء'),
                      ),
                      TextButton(
                        onPressed: () {
                          ref
                              .read(canvasStateProvider.notifier)
                              .clearCanvas();
                          Navigator.pop(context);
                        },
                        child: const Text('تأكيد'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildElementButton(
    BuildContext context,
    WidgetRef ref,
    String label,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    WidgetRef ref,
    String label,
    VoidCallback onPressed, {
    bool enabled = true,
  }) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      child: Text(label),
    );
  }
}
