import 'package:flutter/material.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/HCFLCM.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/UnitConverter.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/grapher.dart';
import 'package:mathx_android/widgets/toolcard.dart';

class ToolsPage extends StatelessWidget {
  ToolsPage({Key? key}) : super(key: key);

  List<Widget> listOfTools = [
    ToolCard(
      name: "Calculator",
      category: ToolCategory.Calculators,
      child: Container(),
    ),
    ToolCard(
      name: "Average Calculator",
      category: ToolCategory.Calculators,
      child: const HCFLCMPage(),
    ),
    ToolCard(
      name: "HCF & LCM Calculator",
      category: ToolCategory.Calculators,
      child: Container(),
    ),
    ToolCard(
      name: "Pythagoras Theorem Calculator",
      category: ToolCategory.Calculators,
      child: Container(),
    ),
    ToolCard(
      name: "Quadratic Calculator",
      category: ToolCategory.Calculators,
      child: Container(),
    ),
    ToolCard(
      name: "Set Calculator",
      category: ToolCategory.Calculators,
      child: Container(),
    ),
    ToolCard(
      name: "Shapes Calculator",
      category: ToolCategory.Calculators,
      child: Container(),
    ),
    ToolCard(
      name: "Trigonometry Calculator",
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
      child: Container(),
    ),
    ToolCard(
      name: "Unit Converter",
      category: ToolCategory.Unit_Converter,
      child: const UnitConverterPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Tools")),
        body: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1),
          padding: EdgeInsets.all(PADDING_BETWEEN_SQUARES),
          children: listOfTools,
        ));
  }
}
