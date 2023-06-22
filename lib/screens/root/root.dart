import 'dart:async';
import 'dart:convert';

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

  StreamSubscription? _sub;
  AppLinks appLinks = AppLinks();

  @override
  void initState() {
    super.initState();

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
          deepLinkParsed: null,
        )
      ];
    });

    _sub = appLinks.allUriLinkStream.listen((uri) {
      print("uri: ${uri.toString()}");

      updateWhenDeepLinkUpdate(uri);
    });
  }

  void updateWhenDeepLinkUpdate(Uri? uri) {
    if (uri.toString().startsWith("mathx:///calculator")) {
      while (Navigator.canPop(context)) {
        Navigator.pop(context);
      }

      setState(() {
        selectedTab = 0;
        selectedTab = 2;
        tabs = [const NotesPage(), const CheatsheetPage(), Container()];
        tabs = List.of([
          const NotesPage(),
          const CheatsheetPage(),
          ToolsPage(
            hideBottomBar: (tohideBottomBar) {
              setState(() {
                print("a");
                hideBottomBar = tohideBottomBar;
              });
            },
            deepLinkParsed: utf8
                .decode(base64Decode(uri
                    .toString()
                    .replaceAll("mathx:///calculator?source=", "")))
                .replaceAll(" -,- ", " ")
                .replaceAll("ET:", "")
                .replaceAll("RT:", "")
                .split(" "),
          )
        ]);
      });
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
