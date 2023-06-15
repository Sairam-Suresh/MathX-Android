import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/logic/tools/CheatsheetsDatabaseHelper.dart';
import 'package:mathx_android/screens/root/tabs/Cheatsheet/cheatsheetviewer.dart';

class CheatsheetPage extends StatefulWidget {
  const CheatsheetPage({Key? key}) : super(key: key);

  @override
  State<CheatsheetPage> createState() => _CheatsheetPageState();
}

class _CheatsheetPageState extends State<CheatsheetPage> {
  List<CheatsheetDetails> cheatsheetsData = [];

  TextEditingController searchController = TextEditingController();
  String? searchText;
  final CheatsheetsDatabaseHelper databaseHelper =
      CheatsheetsDatabaseHelper.instance;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCheatsheets();
  }

  Future<void> loadCheatsheets() async {
    setState(() {
      isLoading = true;
    });

    final List<CheatsheetDetails> cheatSheets =
        await databaseHelper.loadCheatsheetsFromPersistence();
    setState(() {
      cheatsheetsData = cheatSheets;
      isLoading = false;
    });
  }

  Future<void> saveCheatsheets() async {
    await databaseHelper.saveCheatsheetsToPersistence(cheatsheetsData);
  }

  @override
  Widget build(BuildContext context) {
    List<CheatsheetDetails> displayList = [];

    if (searchText != null) {
      for (var element in cheatsheetsData) {
        if (element.title.contains(searchText!)) {
          displayList.add(element);
        }
      }
    } else {
      displayList = cheatsheetsData;
    }

    // To conditionally render the headings if there are topics that fall under them in search
    Set<SecondaryLevel> secondaryLevelsPresent =
        displayList.map((e) => e.secondaryLevel).toSet();

    // extractCheatsheets();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: SearchBar(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    if (value == "") {
                      searchText = null;
                    } else {
                      searchText = value;
                    }
                  });
                },
                hintText: "Search Cheatsheets",
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 15),
                ),
                leading: const Icon(Icons.search),
              ),
            ),
          ),
          isLoading
              ? Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildHeadings(
                              context,
                              "Secondary 1",
                              secondaryLevelsPresent
                                  .contains(SecondaryLevel.one)),
                          buildListViews(displayList, SecondaryLevel.one),
                          buildHeadings(
                              context,
                              "Secondary 2",
                              secondaryLevelsPresent
                                  .contains(SecondaryLevel.two)),
                          buildListViews(displayList, SecondaryLevel.two),
                          buildHeadings(
                              context,
                              "Secondary 3",
                              secondaryLevelsPresent
                                  .contains(SecondaryLevel.three)),
                          buildListViews(displayList, SecondaryLevel.three),
                          buildHeadings(
                              context,
                              "Secondary 4",
                              secondaryLevelsPresent
                                  .contains(SecondaryLevel.four)),
                          buildListViews(displayList, SecondaryLevel.four),
                        ]),
                  ),
                )
        ],
      ),
    );
  }

  Widget buildHeadings(BuildContext context, String text, bool show) {
    return show
        ? Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20),
            child: Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:
                      Theme.of(context).textTheme.headlineSmall?.fontSize),
            ),
          )
        : Container();
  }

  Widget buildListViews(
      List<CheatsheetDetails> displayList, SecondaryLevel level) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: displayList.map((element) {
          if (element.secondaryLevel == level) {
            return ListTile(
              title: AutoSizeText(
                element.title,
                maxLines: 1,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  element.isStarred ? const Icon(Icons.star) : Container(),
                  !element.isComingSoon
                      ? const Icon(Icons.chevron_right)
                      : Container(),
                ],
              ),
              leading: Icon(element.secondaryLevel == SecondaryLevel.one
                  ? Icons.looks_one
                  : element.secondaryLevel == SecondaryLevel.two
                      ? Icons.looks_two
                      : element.secondaryLevel == SecondaryLevel.three
                          ? Icons.looks_3
                          : Icons.looks_4),
              onTap: !element.isComingSoon
                  ? () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CheatSheetViewer(
                          cheatsheet: element,
                          onToggleStarred: (value) {
                            setState(() {
                              cheatsheetsData[cheatsheetsData.contains(element)
                                      ? cheatsheetsData.indexOf(
                                          element) // Somehow putting this condition to make this be 0 if it is -1 makes it work properly for some reason
                                      : 0] =
                                  CheatsheetDetails(
                                      element.title,
                                      element.secondaryLevel,
                                      element.isComingSoon,
                                      value);
                              saveCheatsheets();
                            });
                          },
                        );
                      }));
                    }
                  : null,
            );
          } else {
            return Container();
          }
        }).toList(),
      ),
    );
  }
}
