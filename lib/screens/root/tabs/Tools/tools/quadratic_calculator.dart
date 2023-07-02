import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:mathx_android/logic/tools/QuadraticSolverLogic.dart';
import 'package:mathx_android/widgets/fixedtextfieldlist.dart';

class QuadraticCalculatorPage extends StatefulWidget {
  const QuadraticCalculatorPage({Key? key}) : super(key: key);

  @override
  State<QuadraticCalculatorPage> createState() =>
      _QuadraticCalculatorPageState();
}

class _QuadraticCalculatorPageState extends State<QuadraticCalculatorPage> {
  QuadraticEquation equation = QuadraticEquation(0, 0, 0);
  bool isVisible = true;
  ScrollController scrollController = ScrollController();

  List<String?> values = ["", "", ""];
  bool isFormValid = false;

  int index = 0;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isFormValid) {
      equation = QuadraticEquation(double.parse(values[0]!),
          double.parse(values[1]!), double.parse(values[2]!));
    }

    return Scaffold(
        appBar: AppBar(title: const Text("Quadratic Equation Solver")),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          buildResults(),
                          Card(
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Math.tex(
                                        "${values[0] == "" ? "ax^2" : "${values[0]}x^2"}"
                                        " + "
                                        "${values.elementAtOrNull(1) == "" || values.length < 2 ? "bx" : "${values.elementAt(1)}x"}"
                                        " + "
                                        "${values.elementAtOrNull(2) == "" || values.length != 3 ? "c" : values.elementAt(2)}"
                                        "=0",
                                        textStyle:
                                            const TextStyle(fontSize: 20),
                                      ),
                                    ))),
                          ),
                          FixedTextFieldList(
                              entries: const ["a", "b", "c"],
                              onChange: (newValues, isValid) {
                                setState(() {
                                  isFormValid = isValid;
                                  values =
                                      newValues.map((e) => e ?? "").toList();
                                });
                              })
                        ],
                      ))),
            ],
          ),
        ));
  }

  Widget buildResults() {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text("Y-Intercept"),
            trailing:
                Text(isFormValid ? "(0 ,${equation.getYIntercept()})" : "--"),
          ),
          equation.getNumberOfRoots() >= 1
              ? ListTile(
                  title: const Text("X-Intercept 1"),
                  trailing: Text(isFormValid
                      ? "(0 ,${equation.getXIntercepts()[0]})"
                      : "--"),
                )
              : Container(),
          equation.getNumberOfRoots() == 2
              ? ListTile(
                  title: const Text("X-Intercept 2"),
                  trailing: Text(isFormValid
                      ? "(0 ,${equation.getXIntercepts()[1]})"
                      : "--"),
                )
              : Container(),
          ListTile(
            title: const Text("Line of Symmetry"),
            trailing: Text(
                isFormValid ? "x = ${equation.getLineOfSymmetry()}" : "--"),
          ),
          ListTile(
            title: const Text("Turning Point"),
            trailing: Text(isFormValid
                ? "(${equation.getTurningPointX()} , ${equation.getTurningPointY()})"
                : "--"),
          ),
          ListTile(
            title: const Text("Discriminant"),
            trailing: Text(
                isFormValid ? "${equation.calculateDiscriminant()}" : "--"),
          ),
          ListTile(
            title: const Text("Number of Roots"),
            trailing:
                Text(isFormValid ? "${equation.getNumberOfRoots()}" : "--"),
          ),
        ],
      ),
    );
  }
}
