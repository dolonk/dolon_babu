import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'icon_provider.dart';
import 'icon_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IconProvider(),
      child: const MaterialApp(
        title: 'Icon App',
        home: IconScreen(),
      ),
    );
  }
}


