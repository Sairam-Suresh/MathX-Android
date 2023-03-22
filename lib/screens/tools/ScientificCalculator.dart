import 'package:flutter/material.dart';

class ScientificCalculatorView extends StatefulWidget {
  const ScientificCalculatorView({Key? key}) : super(key: key);

  @override
  State<ScientificCalculatorView> createState() =>
      _ScientificCalculatorViewState();
}

class _ScientificCalculatorViewState extends State<ScientificCalculatorView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Scientific Calculator")),
        body: Column(children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(children: [
                    Row(
                      children: const [
                        Text("0",
                            style:
                                TextStyle(color: Colors.white, fontSize: 30)),
                        Spacer()
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: const [
                        Spacer(),
                        Text("0",
                            style: TextStyle(color: Colors.white, fontSize: 30))
                      ],
                    )
                  ]),
                ),
              ),
            ),
          )
        ]));
  }
}
