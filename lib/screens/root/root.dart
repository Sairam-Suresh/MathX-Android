import 'package:flutter/material.dart';
import 'package:mathx_android/screens/root/tabs/Cheatsheet/cheatsheet.dart';
import 'package:mathx_android/screens/root/tabs/Notes/notes.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools.dart';

class root extends StatefulWidget {
  root({Key? key}) : super(key: key);

  @override
  State<root> createState() => _rootState();
}

class _rootState extends State<root> {
  List<Widget> tabs = [const NotesPage(), const CheatsheetPage(), ToolsPage()];

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.note), label: "Notes"),
          NavigationDestination(icon: Icon(Icons.book), label: "Cheatsheet"),
          NavigationDestination(icon: Icon(Icons.pan_tool), label: "Tools")
        ],
        selectedIndex: selectedTab,
        onDestinationSelected: (index) {
          setState(() {
            selectedTab = index;
          });
        },
      ),
      body: tabs[selectedTab],
    );
  }
}
