dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masra_al_dokhail/presentation/widgets/canvas_widget.dart';
import 'package:masra_al_dokhail/presentation/widgets/toolbar_widget.dart';

class CanvasPage extends StatelessWidget {
  const CanvasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('مرسم الدخيل'),
        elevation: 2,
        centerTitle: true,
      ),
      body: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.grey[100],
            child: const CanvasWidget(),
          ),
        ),
        Container(
          width: 250,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Colors.grey[300]!,
                width: 1,
              ),
            ),
          ),
          child: const ToolbarWidget(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.grey[100],
            child: const CanvasWidget(),
          ),
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey[300]!,
                width: 1,
              ),
            ),
          ),
          child: const ToolbarWidget(),
        ),
      ],
    );
  }
}
