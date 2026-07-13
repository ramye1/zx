dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masra_al_dokhail/presentation/widgets/canvas_widget.dart';
import 'package:masra_al_dokhail/presentation/widgets/toolbar_widget.dart';

class CanvasPage extends ConsumerWidget {
  const CanvasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مرسم الدخيل'),
        elevation: 2,
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[100],
              child: const CanvasWidget(),
            ),
          ),
          Container(
            width: 200,
            color: Colors.white,
            child: const ToolbarWidget(),
          ),
        ],
      ),
    );
  }
}
