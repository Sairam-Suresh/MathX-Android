import 'package:flutter/material.dart';

class CheatSheetCard extends StatelessWidget {
  CheatSheetCard({Key? key, required String name}) : super(key: key);
  late String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        Text("string"),
        Text("string"),
      ]),
    );
  }
}
