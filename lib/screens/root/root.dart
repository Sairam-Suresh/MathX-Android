import 'package:app_links/app_links.dart';
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
  List<Widget> tabs = [];

  int selectedTab = 0;
  bool hideBottomBar = false;
  final _appLinks = AppLinks();

  @override
  void initState() {
    super.initState();

    _appLinks.allUriLinkStream.listen((uri) {
      print("uri: ${uri.toString().startsWith("mathx:///calculator")}");
      if (uri.toString().startsWith("mathx:///calculator")) {
        setState(() {
          selectedTab = 2;
        });
      }
    });

    setState(() {
      tabs = [
        const NotesPage(),
        const CheatsheetPage(),
        ToolsPage(
          hideBottomBar: (tohideBottomBar) {
            setState(() {
              print("a");
              hideBottomBar = tohideBottomBar;
            });
          },
          appLinkInstance: _appLinks,
        )
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    tabs = [
      const NotesPage(),
      const CheatsheetPage(),
      ToolsPage(
        hideBottomBar: (tohideBottomBar) {
          setState(() {
            print("a");
            hideBottomBar = tohideBottomBar;
          });
        },
        appLinkInstance: _appLinks,
      )
    ];

    return Scaffold(
      bottomNavigationBar: !hideBottomBar
          ? NavigationBar(
              destinations: const [
                NavigationDestination(icon: Icon(Icons.note), label: "Notes"),
                NavigationDestination(
                    icon: Icon(Icons.book), label: "Cheatsheet"),
                NavigationDestination(
                    icon: Icon(Icons.pan_tool), label: "Tools")
              ],
              selectedIndex: selectedTab,
              onDestinationSelected: (index) {
                setState(() {
                  selectedTab = index;
                });
              },
            )
          : null,
      body: tabs[selectedTab],
    );
  }
}
