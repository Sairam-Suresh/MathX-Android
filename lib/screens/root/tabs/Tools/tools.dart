import 'package:flutter/material.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/widgets/toolcard.dart';

class ToolsPage extends StatelessWidget {
  ToolsPage({Key? key}) : super(key: key);

  List<Widget> listOfTools = [
    ToolCard(name: "HCF & LCM"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Tools")),
        body: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          padding: EdgeInsets.all(PADDING_BETWEEN_SQUARES),
          children: [ToolCard(name: "HCF & LCM")],
        ));
  }
}
