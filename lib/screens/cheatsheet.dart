import 'package:flutter/material.dart';
import 'package:mathx_android/widgets/CheatSheetCard.dart';

class CheatSheetPage extends StatefulWidget {
  const CheatSheetPage({Key? key}) : super(key: key);

  @override
  State<CheatSheetPage> createState() => _CheatSheetPageState();
}

class _CheatSheetPageState extends State<CheatSheetPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: Row(
            children: [
              Flexible(
                  fit: FlexFit.tight, child: CheatSheetCard(name: "hello4")),
              Flexible(
                  fit: FlexFit.tight, child: CheatSheetCard(name: "hello1")),
            ],
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: Row(
            children: [
              Flexible(
                  fit: FlexFit.tight, child: CheatSheetCard(name: "hello2")),
              Flexible(
                  fit: FlexFit.tight, child: CheatSheetCard(name: "hello3")),
            ],
          ),
        )
      ],
    );
  }
}
