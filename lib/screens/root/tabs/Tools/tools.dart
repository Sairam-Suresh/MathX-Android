import 'package:flutter/material.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/HCF_LCM_calculator.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/UnitConverter.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/average_calculator.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/grapher.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/pythagoras_theorem_calculator.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/quadratic_calculator.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/randomiser.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/shapes_calculator.dart';
import 'package:mathx_android/widgets/toolcard.dart';

class ToolsPage extends StatefulWidget {
  ToolsPage({Key? key}) : super(key: key);

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  List<ToolCard> listOfTools = [
    ToolCard(
      name: "Calculator",
      category: ToolCategory.Calculators,
      child: Container(),
    ),
    ToolCard(
      name: "Average Calculator",
      category: ToolCategory.Calculators,
      child: const AverageCalculatorPage(),
    ),
    ToolCard(
      name: "HCF & LCM Calculator",
      category: ToolCategory.Calculators,
      child: const HCFLCMPage(),
    ),
    ToolCard(
      name: "Pythagoras Theorem Calculator",
      category: ToolCategory.Calculators,
      child: const PythagorasTheoremCalculatorPage(),
    ),
    ToolCard(
      name: "Quadratic Calculator",
      category: ToolCategory.Calculators,
      child: const QuadraticCalculatorPage(),
    ),
    ToolCard(
      name: "Set Calculator",
      category: ToolCategory.Calculators,
      child: Container(),
    ),
    ToolCard(
      name: "Shapes Calculator",
      category: ToolCategory.Calculators,
      child: const ShapesCalculatorPage(),
    ),
    ToolCard(
      name: "Trigonometry Calculator",
      category: ToolCategory.Calculators,
      child: Container(),
    ),
    ToolCard(
      name: "Binary Calculator",
      category: ToolCategory.Calculators,
      child: Container(),
    ),
    ToolCard(
      name: "Grapher (Desmos)",
      category: ToolCategory.Graphers,
      child: const GrapherPage(),
    ),
    ToolCard(
      name: "Randomise",
      category: ToolCategory.Randomise,
      child: const RandomiserPage(),
    ),
    ToolCard(
      name: "Unit Converter",
      category: ToolCategory.Unit_Converter,
      child: const UnitConverterPage(),
    ),
  ];

  List<ToolCategory> filters = [
    ToolCategory.Calculators,
    ToolCategory.Graphers,
    ToolCategory.Randomise,
    ToolCategory.Unit_Converter
  ];

  List<Widget> displayedTools = [];

  @override
  Widget build(BuildContext context) {
    void outerSetState(dynamic value) {
      setState(() {
        value = value;
      });
    }

    displayedTools = [];

    for (ToolCard widget in listOfTools) {
      if (filters.contains(widget.category)) {
        displayedTools.add(widget);
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Tools"),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: false,
                  builder: (BuildContext context) {
                    return BottomSheet(
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return SizedBox(
                            // To force the Bottom sheet to become full size
                            height: MediaQuery.of(context).size.height,
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  PADDING_FOR_MODAL_BOTTOM_SHEET),
                              child: Column(
                                children: [
                                  const Text(
                                    "Filter",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  CheckboxListTile(
                                    title: const Text('Calculators'),
                                    value: filters
                                        .contains(ToolCategory.Calculators),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        value!
                                            ? filters
                                                .add(ToolCategory.Calculators)
                                            : filters.remove(
                                                ToolCategory.Calculators);
                                        outerSetState("a");
                                      });
                                    },
                                    secondary: const Icon(Icons.calculate),
                                  ),
                                  CheckboxListTile(
                                    title: const Text('Graphers'),
                                    value:
                                        filters.contains(ToolCategory.Graphers),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        value!
                                            ? filters.add(ToolCategory.Graphers)
                                            : filters
                                                .remove(ToolCategory.Graphers);
                                        outerSetState("m");
                                      });
                                    },
                                    secondary: const Icon(Icons.graphic_eq),
                                  ),
                                  CheckboxListTile(
                                    title: const Text('Randomise'),
                                    value: filters
                                        .contains(ToolCategory.Randomise),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        value!
                                            ? filters
                                                .add(ToolCategory.Randomise)
                                            : filters
                                                .remove(ToolCategory.Randomise);
                                        outerSetState("o");
                                      });
                                    },
                                    secondary: const Icon(Icons.shuffle),
                                  ),
                                  CheckboxListTile(
                                    title: const Text('Unit Converter'),
                                    value: filters
                                        .contains(ToolCategory.Unit_Converter),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        value!
                                            ? filters.add(
                                                ToolCategory.Unit_Converter)
                                            : filters.remove(
                                                ToolCategory.Unit_Converter);
                                        outerSetState("g");
                                      });
                                    },
                                    secondary: const Icon(Icons.refresh),
                                  ),
                                  Row(
                                    children: [
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: FilledButton(
                                            onPressed: () {
                                              setState(() {
                                                filters = [
                                                  ToolCategory.Calculators,
                                                  ToolCategory.Graphers,
                                                  ToolCategory.Randomise,
                                                  ToolCategory.Unit_Converter
                                                ];
                                              });
                                              outerSetState("among");
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Clear filters")),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: FilledButton(
                                            onPressed: () {
                                              setState(() {});
                                              outerSetState("among1");
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Apply filters")),
                                      ),
                                      const Spacer(),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                      },
                      onClosing: () {},
                      enableDrag: false,
                    );
                  },
                );
              },
            )
          ],
        ),
        body: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1),
          padding: const EdgeInsets.all(PADDING_BETWEEN_SQUARES),
          children: displayedTools,
        ));
  }
}
