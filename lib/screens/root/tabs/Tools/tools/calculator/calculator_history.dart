import 'package:flutter/material.dart';
import 'package:mathx_android/logic/tools/CalculatorLogic.dart';

class CalculatorHistory extends StatelessWidget {
  const CalculatorHistory({super.key, required this.history});

  final List<Calculation> history;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
      ),
      body: ListView.builder(
          itemCount: history.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(history[index]
                    .expression
                    .replaceAll("*", "×")
                    .replaceAll("/", "÷")),
                subtitle: Text(history[index].result.toString()),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Container()));
                });
          }),
    );
  }
}
