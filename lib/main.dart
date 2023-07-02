import 'package:flutter/material.dart';
import 'package:mathx_android/screens/root/root.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MathX',
        theme: ThemeData(
          colorSchemeSeed: const Color.fromARGB(255, 169, 100, 255),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorSchemeSeed: const Color.fromARGB(255, 169, 100, 255),
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        home: const Root());
  }
}
