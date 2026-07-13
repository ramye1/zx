import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masra_al_dokhail/presentation/pages/canvas_page.dart';
import 'package:masra_al_dokhail/presentation/providers/app_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MasraAlDokhailApp()));
}

class MasraAlDokhailApp extends StatelessWidget {
  const MasraAlDokhailApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مرسم الدخيل',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CanvasPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

