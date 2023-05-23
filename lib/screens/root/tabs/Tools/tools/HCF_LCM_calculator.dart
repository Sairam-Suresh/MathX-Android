import 'package:flutter/material.dart';
import 'package:mathx_android/widgets/tool.dart';

class HCFLCMPage extends StatefulWidget {
  const HCFLCMPage({Key? key}) : super(key: key);

  @override
  State<HCFLCMPage> createState() => _HCFLCMPageState();
}

class _HCFLCMPageState extends State<HCFLCMPage> {
  bool firstRender = true;

  @override
  Widget build(BuildContext context) {
    // TODO: Need to make HCF have an option to have only prime numbers

    return Tool(
      displayOptions: [Text("hello")],
      tabs: {"aaa": Text("aaa"), "bbb": Text("bbb")},
      innerTabs: null,
    );
  }
}
