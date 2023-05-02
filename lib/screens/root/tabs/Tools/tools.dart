import 'package:flutter/material.dart';

class ToolsPage extends StatelessWidget {
  const ToolsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Tools")),
        body: Center(
          child: Text("Tools"),
        ));
  }
}
