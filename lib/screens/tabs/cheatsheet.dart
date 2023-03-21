import 'package:flutter/material.dart';

class CheatSheetPage extends StatefulWidget {
  const CheatSheetPage({Key? key}) : super(key: key);

  @override
  State<CheatSheetPage> createState() => _CheatSheetPageState();
}

class _CheatSheetPageState extends State<CheatSheetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hello world"),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Placeholder()),
    );
  }
}
