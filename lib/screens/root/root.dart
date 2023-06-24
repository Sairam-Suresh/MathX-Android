import 'dart:async';
import 'dart:convert';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/screens/root/tabs/Cheatsheet/cheatsheet.dart';
import 'package:mathx_android/screens/root/tabs/Notes/notepreview.dart';
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

  bool needNotesPageRebuild = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      tabs = [
        const NotesPage(),
        const CheatsheetPage(),
        ToolsPage(
          hideTopAndBottom: (tohideBottomBar) {
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
      while (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      if (uri.toString().startsWith(calculatorURLAccessor)) {
        updateWhenDeepLinkUpdateCalculator(uri);
      } else if (uri.toString().startsWith(notesURLAccessor)) {
        updateWhenDeepLinkUpdateNote(uri);
      }
    });
  }

  void updateWhenDeepLinkUpdateNote(uri) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NotePreview(
                  note: Note.fromDeepLink(uri.toString()),
                  onChange: () {
                    setState(() {
                      selectedTab = 2;
                      tabs = List.of([
                        NotesPage(
                          deepLinkNote: Note.fromDeepLink(uri.toString()),
                        ),
                        const CheatsheetPage(),
                        ToolsPage(
                          hideTopAndBottom: (tohideBottomBar) {
                            setState(() {
                              print("a");
                              hideBottomBar = tohideBottomBar;
                            });
                          },
                        )
                      ]);
                    });
                    setState(() {
                      selectedTab = 0;
                    });
                  },
                ),
            fullscreenDialog: true));
  }

  void updateWhenDeepLinkUpdateCalculator(Uri? uri) {
    setState(() {
      selectedTab = 0;
      selectedTab = 2;
      tabs = [const NotesPage(), const CheatsheetPage(), Container()];
      tabs = List.of([
        const NotesPage(),
        const CheatsheetPage(),
        ToolsPage(
          hideTopAndBottom: (tohideBottomBar) {
            setState(() {
              print("a");
              hideBottomBar = tohideBottomBar;
            });
          },
          deepLinkParsed: utf8
              .decode(base64Decode(
                  uri.toString().replaceAll("mathx:///calculator?source=", "")))
              .replaceAll(" -,- ", " ")
              .replaceAll("ET:", "")
              .replaceAll("RT:", "")
              .split(" "),
        )
      ]);
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant root oldWidget) {
    build(context);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: selectedTab == 2 ? false : true,
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
