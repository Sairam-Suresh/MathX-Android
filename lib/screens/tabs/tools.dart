import 'package:flutter/material.dart';

class ToolsPage extends StatefulWidget {
  const ToolsPage({Key? key}) : super(key: key);

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

// this class acts as a data class which will help to contain a color, text, and a widget.
class ToolsData {
  late final Color color;
  late final String toolName;
  late final Widget widget;
}

class _ToolsPageState extends State<ToolsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tools"), automaticallyImplyLeading: false),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          ToolTile(
            color: Colors.red,
            text: "HCF and LCM",
          ),
          ToolTile(
            text: "Algebra",
          ),
          ToolTile(
            text: "Instruments",
          ),
          ToolTile(
            text: "hello",
          ),
          ToolTile(
            text: "hello",
          ),
          ToolTile(
            text: "helllo",
          ),
          ToolTile(
            text: "hello",
          ),
          ToolTile(
            text: "hello",
          ),
          ToolTile(
            text: "hello",
          ),
        ],
      ),
    );
  }
}

class ToolTile extends StatelessWidget {
  ToolTile({super.key, this.color, required this.text});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: color ?? Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurStyle: BlurStyle.outer,
              blurRadius: 3,
            )
          ]),
      padding: const EdgeInsets.all(8),
      child: Center(
          child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      )),
    );
  }
}
