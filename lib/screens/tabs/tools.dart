import 'package:flutter/material.dart';

class ToolsPage extends StatefulWidget {
  const ToolsPage({Key? key}) : super(key: key);

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tools")),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          ToolTile(
            color: Colors.red,
            child: Text("hello"),
          ),
          ToolTile(
            color: Colors.red,
            child: Text("hello"),
          ),
          ToolTile(
            color: Colors.red,
            child: Text("hello"),
          ),
          ToolTile(
            color: Colors.red,
            child: Text("hello"),
          ),
          ToolTile(
            color: Colors.red,
            child: Text("hello"),
          ),
          ToolTile(
            color: Colors.red,
            child: Text("hello"),
          ),
          ToolTile(
            color: Colors.red,
            child: Text("hello"),
          ),
          ToolTile(
            color: Colors.red,
            child: Text("hello"),
          ),
          ToolTile(
            color: Colors.red,
            child: Text("hello"),
          ),
        ],
      ),
    );
  }
}

class ToolTile extends StatelessWidget {
  ToolTile({super.key, required this.color, required this.child});

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)), color: color),
      padding: const EdgeInsets.all(8),
      child: child,
    );
  }
}
