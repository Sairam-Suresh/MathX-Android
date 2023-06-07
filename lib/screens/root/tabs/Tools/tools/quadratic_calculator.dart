import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:mathx_android/logic/tools/QuadraticSolverLogic.dart';
import 'package:mathx_android/widgets/textfieldlist.dart';

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

  TextFieldListController controller = TextFieldListController();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  Widget? textFields;
  int index = 0;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    textFields = TextFieldList(
      controller: controller,
      formKey: formKey,
      onChange: (_) {
        setState(() {});
      },
      limitEntries: {"a": null, "b": null, "c": null},
    );

    if (formKey.currentState?.isValid ?? false) {
      equation = QuadraticEquation(
          double.parse(controller.textFieldValues[0]),
          double.parse(controller.textFieldValues[1]),
          double.parse(controller.textFieldValues[2]));
    }

    return Scaffold(
        appBar: AppBar(title: const Text("Quadratic Equation Solver")),
        body: Column(
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
                                      "${controller.textFieldValues[0] == "" ? "ax^2" : "${controller.textFieldValues[0]}x^2"}"
                                      " + "
                                      "${controller.textFieldValues.elementAtOrNull(1) == "" || controller.textFieldValues.length < 2 ? "bx" : "${controller.textFieldValues.elementAt(1)}x"}"
                                      " + "
                                      "${controller.textFieldValues.elementAtOrNull(2) == "" || controller.textFieldValues.length != 3 ? "c" : controller.textFieldValues.elementAt(2)}"
                                      "=0",
                                      textStyle: const TextStyle(fontSize: 20),
                                    ),
                                  ))),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: textFields!,
                        ),
                      ],
                    ))),
          ],
        ));
  }

  Widget buildResults() {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text("Y-Intercept"),
            trailing: Text((formKey.currentState?.isValid ?? false)
                ? "(0 ,${equation.getYIntercept()})"
                : "--"),
          ),
          equation.getNumberOfRoots() >= 1
              ? ListTile(
                  title: const Text("X-Intercept 1"),
                  trailing: Text((formKey.currentState?.isValid ?? false)
                      ? "(0 ,${equation.getXIntercepts()[0]})"
                      : "--"),
                )
              : Container(),
          equation.getNumberOfRoots() == 2
              ? ListTile(
                  title: const Text("X-Intercept 2"),
                  trailing: Text((formKey.currentState?.isValid ?? false)
                      ? "(0 ,${equation.getXIntercepts()[1]})"
                      : "--"),
                )
              : Container(),
          ListTile(
            title: const Text("Line of Symmetry"),
            trailing: Text((formKey.currentState?.isValid ?? false)
                ? "x = ${equation.getLineOfSymmetry()}"
                : "--"),
          ),
          ListTile(
            title: const Text("Turning Point"),
            trailing: Text((formKey.currentState?.isValid ?? false)
                ? "(${equation.getTurningPointX()} , ${equation.getTurningPointY()})"
                : "--"),
          ),
          ListTile(
            title: const Text("Discriminant"),
            trailing: Text((formKey.currentState?.isValid ?? false)
                ? "${equation.calculateDiscriminant()}"
                : "--"),
          ),
          ListTile(
            title: const Text("Number of Roots"),
            trailing: Text((formKey.currentState?.isValid ?? false)
                ? "${equation.getNumberOfRoots()}"
                : "--"),
          ),
        ],
      ),
    );
  }
}
