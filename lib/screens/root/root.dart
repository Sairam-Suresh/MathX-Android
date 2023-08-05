import 'dart:async';
import 'dart:convert';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/screens/root/tabs/Cheatsheet/cheatsheet.dart';
import 'package:mathx_android/screens/root/tabs/Notes/notepreview.dart';
import 'package:mathx_android/screens/root/tabs/Notes/notes.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools.dart';
import 'package:mathx_android/screens/welcome/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  List<Widget> tabs = [];

  int selectedTab = 0;
  bool hideBottomBar = false;

  StreamSubscription? _sub;
  AppLinks appLinks = AppLinks();

  bool needNotesPageRebuild = false;
  bool? hasConfirmedAlreadyShowingWelcome;

  @override
  void initState() {
    super.initState();

    (() async {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        hasConfirmedAlreadyShowingWelcome = prefs.getBool('isLoaded') ?? false;

        if (!(hasConfirmedAlreadyShowingWelcome ?? false)) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const WelcomeScreen(),
                  fullscreenDialog: true));
        }
      });
    })();

    setState(() {
      tabs = [
        const NotesPage(),
        const CheatsheetPage(),
        ToolsPage(
          hideTopAndBottom: (toHideBottomBar) {
            setState(() {
              hideBottomBar = toHideBottomBar;
            });
          },
          deepLinkParsed: null,
        )
      ];
    });

    _sub = appLinks.allUriLinkStream.listen((uri) {
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
                      tabs = [
                        NotesPage(
                          deepLinkNote: Note.fromDeepLink(uri.toString()),
                        ),
                        const CheatsheetPage(),
                        ToolsPage(
                          hideTopAndBottom: (tohideBottomBar) {
                            setState(() {
                              hideBottomBar = tohideBottomBar;
                            });
                          },
                        )
                      ];
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
      tabs = [
        const NotesPage(),
        const CheatsheetPage(),
        ToolsPage(
          hideTopAndBottom: (tohideBottomBar) {
            setState(() {
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
      ];
      selectedTab = 2;
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (selectedTab != 2) {
      hideBottomBar = false;
    }

    return Scaffold(
      resizeToAvoidBottomInset: selectedTab == 2 ? false : true,
      bottomNavigationBar: !hideBottomBar
          ? NavigationBar(
              destinations: [
                const NavigationDestination(
                    icon: Icon(Icons.note), label: "Notes"),
                const NavigationDestination(
                    icon: Icon(Icons.book), label: "Cheatsheet"),
                NavigationDestination(
                    icon: Icon(Icons.construction), label: "Tools")
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
