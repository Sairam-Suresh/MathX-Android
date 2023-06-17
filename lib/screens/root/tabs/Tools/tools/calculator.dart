import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:mathx_android/logic/tools/CalculatorLogic.dart';

enum Mode { normal, sharing }

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  Calculator instance = Calculator();
  String expressionText = "";
  Mode mode = Mode.normal;
  bool gotResult = true;
  double? results;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(children: [
                      Row(
                        children: [
                          Text(expressionText,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 30)),
                          const Spacer()
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Spacer(),
                          Text((results ?? "").toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 30))
                        ],
                      )
                    ]),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 4,
            child: LayoutGrid(rowSizes: [
              1.fr,
              1.fr,
              1.fr,
              1.fr,
              1.fr
            ], columnSizes: [
              1.fr,
              1.fr,
              1.fr,
              1.fr,
              1.fr
            ], children: [
              // Row 1

              CalculatorButton(
                      content: Icon(
                        Icons.history,
                        size: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.fontSize,
                      ),
                      onPressed: () {})
                  .withGridPlacement(rowStart: 0, columnStart: 0),
              CalculatorButton(
                      content: Icon(
                        Icons.share,
                        size: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.fontSize,
                      ),
                      onPressed: () {})
                  .withGridPlacement(rowStart: 0, columnStart: 1),
              CalculatorButton(
                      content: Text("√",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                      onPressed: () {})
                  .withGridPlacement(rowStart: 0, columnStart: 2),
              CalculatorButton(
                content: Text("DEL",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                onPressed: () {
                  setState(() {
                    if (mode == Mode.normal) {
                      if (expressionText.isNotEmpty) {
                        expressionText = expressionText.substring(
                            0, expressionText.length - 1);
                      }
                    }
                  });
                },
                foregroundColor: Colors.black,
                backgroundColor: Colors.yellow,
              ).withGridPlacement(rowStart: 0, columnStart: 3),
              CalculatorButton(
                content: Text("AC",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                onPressed: () {
                  setState(() {
                    if (mode == Mode.normal) {
                      expressionText = "";
                    }
                  });
                },
                foregroundColor: Colors.black,
                backgroundColor: Colors.yellow,
              ).withGridPlacement(rowStart: 0, columnStart: 4),

              // Row 2
              CalculatorButton(
                  content: Text("7",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                  onPressed: () {
                    setState(() {
                      if (mode == Mode.normal) {
                        expressionText += "7";
                      }
                    });
                  }).withGridPlacement(rowStart: 1, columnStart: 0),
              CalculatorButton(
                  content: Text("8",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                  onPressed: () {
                    setState(() {
                      if (mode == Mode.normal) {
                        expressionText += "8";
                      }
                    });
                  }).withGridPlacement(rowStart: 1, columnStart: 1),
              CalculatorButton(
                  content: Text("9",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                  onPressed: () {
                    setState(() {
                      if (mode == Mode.normal) {
                        expressionText += "9";
                      }
                    });
                  }).withGridPlacement(rowStart: 1, columnStart: 2),
              CalculatorButton(
                  content: Text("(",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                  onPressed: () {
                    setState(() {
                      if (mode == Mode.normal) {
                        expressionText += "(";
                      }
                    });
                  }).withGridPlacement(rowStart: 1, columnStart: 3),
              CalculatorButton(
                  content: Text(")",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                  onPressed: () {
                    setState(() {
                      if (mode == Mode.normal) {
                        expressionText += ")";
                      }
                    });
                  }).withGridPlacement(rowStart: 1, columnStart: 4),

              // Row 3
              CalculatorButton(
                      content: Text("4",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                      onPressed: () {})
                  .withGridPlacement(rowStart: 2, columnStart: 0),
              CalculatorButton(
                      content: Text("5",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                      onPressed: () {})
                  .withGridPlacement(rowStart: 2, columnStart: 1),
              CalculatorButton(
                      content: Text("6",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                      onPressed: () {})
                  .withGridPlacement(rowStart: 2, columnStart: 2),
              CalculatorButton(
                      content: Text("×",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                      onPressed: () {})
                  .withGridPlacement(rowStart: 2, columnStart: 3),
              CalculatorButton(
                      content: Text("÷",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                      onPressed: () {})
                  .withGridPlacement(rowStart: 2, columnStart: 4),
              // Row 4
              CalculatorButton(
                      content: Text("1",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                      onPressed: () {})
                  .withGridPlacement(rowStart: 3, columnStart: 0),
              CalculatorButton(
                      content: Text("2",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                      onPressed: () {})
                  .withGridPlacement(rowStart: 3, columnStart: 1),
              CalculatorButton(
                      content: Text("3",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                      onPressed: () {})
                  .withGridPlacement(rowStart: 3, columnStart: 2),
              CalculatorButton(
                      content: Text("+",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                      onPressed: () {})
                  .withGridPlacement(rowStart: 3, columnStart: 3),
              CalculatorButton(
                      content: Text("-",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                      onPressed: () {})
                  .withGridPlacement(rowStart: 3, columnStart: 4),
              // Row 5
              CalculatorButton(
                      content: Text("0",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                      onPressed: () {})
                  .withGridPlacement(
                      rowStart: 4, columnStart: 0, columnSpan: 2),
              CalculatorButton(
                      content: Text(".",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                      onPressed: () {})
                  .withGridPlacement(rowStart: 4, columnStart: 2),
              CalculatorButton(
                      content: Text("Ans",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                      onPressed: () {})
                  .withGridPlacement(rowStart: 4, columnStart: 3),
              CalculatorButton(
                  content: Text("=",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                  onPressed: () {
                    setState(() {
                      setState(() {
                        if (mode == Mode.normal) {
                          print(instance.evaluate(expressionText));
                        }
                      });
                    });
                  }).withGridPlacement(rowStart: 4, columnStart: 4),
            ]),
          ),
        ],
      ),
    ));
  }
}

class CalculatorButton extends StatelessWidget {
  final Widget content;
  final Function() onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;

  const CalculatorButton({
    Key? key,
    required this.content,
    required this.onPressed,
    this.foregroundColor,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  foregroundColor: foregroundColor ?? Colors.white,
                  backgroundColor:
                      backgroundColor ?? Colors.black, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Rounded corners
                  ),
                ),
                child: Center(child: content),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
