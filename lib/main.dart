import 'package:flutter/material.dart';
import 'package:mathx_android/screens/cheatsheet.dart';
import 'package:mathx_android/screens/notes.dart';
import 'package:mathx_android/screens/tools.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.notes), label: 'Notes'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Cheat Sheet'),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Tools'),
        ],
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
      body: returnTabContent(index,
          [const NotesPage(), const CheatSheetPage(), const ToolsPage()]),
    );
  }

  Widget returnTabContent(int index, List<Widget> widgets) {
    return widgets[index];
  }
}
