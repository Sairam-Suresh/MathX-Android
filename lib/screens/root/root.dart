import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mathx_android/screens/root/tabs/Cheatsheet/cheatsheet.dart';
import 'package:mathx_android/screens/root/tabs/Notes/notes.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools.dart';
import 'package:uni_links/uni_links.dart';

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

    (() async {
      final firstLink = await getInitialUri();
      if (firstLink != null) {
        updateWhenDeepLinkUpdate(firstLink);
      }
    })();

    _sub = uriLinkStream.listen((uri) {
      print("uri: ${uri.toString().startsWith("mathx:///calculator")}");
      updateWhenDeepLinkUpdate(uri);
    });
  }

  void updateWhenDeepLinkUpdate(Uri? uri) {
    if (uri.toString().startsWith("mathx:///calculator")) {
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
