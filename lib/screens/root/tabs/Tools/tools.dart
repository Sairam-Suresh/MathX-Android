import 'package:flutter/material.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/HCFLCM.dart';
import 'package:mathx_android/widgets/toolcard.dart';

class ToolsPage extends StatelessWidget {
  ToolsPage({Key? key}) : super(key: key);

  List<Widget> listOfTools = [
    ToolCard(
      name: "HCF & LCM",
      category: ToolCategory.Calculators,
      child: const HCFLCMPage(),
    )
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
