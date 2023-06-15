import 'package:flutter/material.dart';
import 'package:mathx_android/screens/root/tabs/Cheatsheet/cheatsheetviewer.dart';

enum SecondaryLevel { one, two, three, four }

class CheatsheetDetails {
  String title;
  SecondaryLevel secondaryLevel;
  bool isComingSoon;

  CheatsheetDetails(this.title, this.secondaryLevel,
      [this.isComingSoon = false]);
}

var cheatsheetsData = [
  CheatsheetDetails("Numbers and Their Operations Part 1", SecondaryLevel.one),
  CheatsheetDetails("Numbers and Their Operations Part 2", SecondaryLevel.one),
  CheatsheetDetails("Percentages", SecondaryLevel.one),
  CheatsheetDetails(
      "Basic Algebra and Algebraic Manipulation", SecondaryLevel.one),
  CheatsheetDetails("Linear Equations and Inequalities", SecondaryLevel.one),
  CheatsheetDetails("Functions and Linear Graphs", SecondaryLevel.one),
  CheatsheetDetails("Basic Geometry", SecondaryLevel.one),
  CheatsheetDetails("Polygons", SecondaryLevel.one),
  CheatsheetDetails("Geometrical Construction", SecondaryLevel.one),
  CheatsheetDetails("Number Sequences", SecondaryLevel.one),
  CheatsheetDetails("Similarity and Congruence Part 1", SecondaryLevel.two),
  CheatsheetDetails("Similarity and Congruence Part 2", SecondaryLevel.two),
  CheatsheetDetails("Ratio and Proportion", SecondaryLevel.two),
  CheatsheetDetails("Direct and Inverse Proportions", SecondaryLevel.two),
  CheatsheetDetails("Pythagoras Theorem", SecondaryLevel.two),
  CheatsheetDetails("Trigonometric Ratios", SecondaryLevel.two),
  CheatsheetDetails("Indices", SecondaryLevel.three),
  CheatsheetDetails("Surds", SecondaryLevel.three),
  CheatsheetDetails("Functions and Graphs", SecondaryLevel.three),
  CheatsheetDetails(
      "Quadratic Functions, Equations, and Inequalities", SecondaryLevel.three),
  CheatsheetDetails("Coordinate Geometry", SecondaryLevel.three),
  CheatsheetDetails("Exponentials and Logarithms", SecondaryLevel.three),
  CheatsheetDetails("Further Coordinate Geometry", SecondaryLevel.three),
  CheatsheetDetails("Linear Law", SecondaryLevel.three),
  CheatsheetDetails("Geometrical Properties of Circles", SecondaryLevel.three),
  CheatsheetDetails("Polynomials and Partial Fractions", SecondaryLevel.three),
  CheatsheetDetails("Coming Soon...", SecondaryLevel.four, true)
];

class CheatsheetPage extends StatefulWidget {
  const CheatsheetPage({Key? key}) : super(key: key);

  @override
  State<CheatsheetPage> createState() => _CheatsheetPageState();
}

class _CheatsheetPageState extends State<CheatsheetPage> {
  // create texteditingcontroller for search
  TextEditingController searchController = TextEditingController();
  String? searchText;

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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeadings(context, "Secondary 1",
                        secondaryLevelsPresent.contains(SecondaryLevel.one)),
                    buildListViews(displayList, SecondaryLevel.one),
                    buildHeadings(context, "Secondary 2",
                        secondaryLevelsPresent.contains(SecondaryLevel.two)),
                    buildListViews(displayList, SecondaryLevel.two),
                    buildHeadings(context, "Secondary 3",
                        secondaryLevelsPresent.contains(SecondaryLevel.three)),
                    buildListViews(displayList, SecondaryLevel.three),
                    buildHeadings(context, "Secondary 4",
                        secondaryLevelsPresent.contains(SecondaryLevel.four)),
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
              title: Text(
                element.title,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(element.secondaryLevel == SecondaryLevel.one
                      ? Icons.looks_one
                      : element.secondaryLevel == SecondaryLevel.two
                          ? Icons.looks_two
                          : element.secondaryLevel == SecondaryLevel.three
                              ? Icons.looks_3
                              : Icons.looks_4),
                  !element.isComingSoon
                      ? const Icon(Icons.chevron_right)
                      : Container(),
                ],
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CheatSheetViewer();
                }));
              },
            );
          } else {
            return Container();
          }
        }).toList(),
      ),
    );
  }
}
