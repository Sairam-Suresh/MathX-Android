import 'package:flutter/material.dart';
import 'package:mathx_android/screens/tabs/cheatsheet.dart';
import 'package:mathx_android/screens/tabs/notes.dart';
import 'package:mathx_android/screens/tabs/tools.dart';

class TabRootController extends StatefulWidget {
  const TabRootController({super.key, required this.title});
  final String title;

  @override
  State<TabRootController> createState() => _TabRootControllerState();
}

class _TabRootControllerState extends State<TabRootController> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
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

  dynamic returnRelatingTabData(int index, List data) {
    return data[index];
  }
}
