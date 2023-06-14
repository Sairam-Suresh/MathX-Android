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

class CheatsheetPage extends StatelessWidget {
  const CheatsheetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cheatsheets"),
      ),
      body: ListView.builder(
          itemCount: 4,
          shrinkWrap: true,
          itemBuilder: (BuildContext buildContext, int index) {
            return ExpansionTile(
              title: Text("Secondary ${index + 1}"),
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cheatsheetsData[index].length,
                  itemBuilder: (context, innerIndex) {
                    return ListTile(
                      title: Text(
                        cheatsheetsData[index][innerIndex].title,
                      ),
                      trailing:
                          cheatsheetsData[index][innerIndex].notePath != null
                              ? Icon(Icons.chevron_right)
                              : null,
                    );
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
    );
  }
}
