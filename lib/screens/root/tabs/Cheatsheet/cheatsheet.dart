import 'package:flutter/material.dart';

class CheatsheetDetails {
  final String title;
  final String? notePath;

  CheatsheetDetails(this.title, this.notePath);
}

var cheatsheetsData = [
  [
    CheatsheetDetails("Numbers and Their Operations Part 1", ""),
    CheatsheetDetails("Numbers and Their Operations Part 2", ""),
    CheatsheetDetails("Percentages", ""),
    CheatsheetDetails("Basic Algebra and Algebraic Manipulation", ""),
    CheatsheetDetails("Linear Equations and Inequalities", ""),
    CheatsheetDetails("Functions and Linear Graphs", ""),
    CheatsheetDetails("Basic Geometry", ""),
    CheatsheetDetails("Polygons", ""),
    CheatsheetDetails("Geometrical Construction", ""),
    CheatsheetDetails("Number Sequences", ""),
  ],
  [
    CheatsheetDetails("Similarity and Congruence Part 1", ""),
    CheatsheetDetails("Similarity and Congruence Part 2", ""),
    CheatsheetDetails("Ratio and Proportion", ""),
    CheatsheetDetails("Direct and Inverse Proportions", ""),
    CheatsheetDetails("Pythagoras Theorem", ""),
    CheatsheetDetails("Trigonometric Ratios", ""),
  ],
  [
    CheatsheetDetails("Indices", ""),
    CheatsheetDetails("Surds", ""),
    CheatsheetDetails("Functions and Graphs", ""),
    CheatsheetDetails("Quadratic Functions, Equations, and Inequalities", ""),
    CheatsheetDetails("Coordinate Geometry", ""),
    CheatsheetDetails("Exponentials and Logarithms", ""),
    CheatsheetDetails("Further Coordinate Geometry", ""),
    CheatsheetDetails("Linear Law", ""),
    CheatsheetDetails("Geometrical Properties of Circles", ""),
    CheatsheetDetails("Polynomials and Partial Fractions", "")
  ],
  [CheatsheetDetails("Coming Soon...", null)],
];

class CheatsheetPage extends StatefulWidget {
  const CheatsheetPage({Key? key}) : super(key: key);

  @override
  State<CheatsheetPage> createState() => _CheatsheetPageState();
}

class _CheatsheetPageState extends State<CheatsheetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: SearchBar(
                  // controller: searchController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  hintText: "Search Cheatsheets",
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(horizontal: 15),
                  ),
                  leading: const Icon(Icons.search),
                ),
              ),
            ),
            ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext buildContext, int index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 20),
                        child: Text(
                          "Secondary ${index + 1}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.fontSize),
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cheatsheetsData[index].length,
                        itemBuilder: (context, innerIndex) {
                          return ListTile(
                              title: Text(
                                cheatsheetsData[index][innerIndex].title,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(index == 0
                                      ? Icons.looks_one
                                      : index == 1
                                          ? Icons.looks_two
                                          : index == 2
                                              ? Icons.looks_3
                                              : Icons.looks_4),
                                  cheatsheetsData[index][innerIndex].notePath !=
                                          null
                                      ? Icon(Icons.chevron_right)
                                      : Container(),
                                ],
                              ));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Divider(),
                          );
                        },
                      )
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
