import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mathx_android/logic/tools/QuadraticSolverLogic.dart';
import 'package:mathx_android/widgets/tooltemplate.dart';

class QuadraticCalculatorPage extends StatefulWidget {
  const QuadraticCalculatorPage({Key? key}) : super(key: key);

  @override
  State<QuadraticCalculatorPage> createState() =>
      _QuadraticCalculatorPageState();
}

class _QuadraticCalculatorPageState extends State<QuadraticCalculatorPage> {
  QuadraticEquation equation = QuadraticEquation(0, 0, 0);

  @override
  Widget build(BuildContext context) {
    return Tool(
        appbar: AppBar(title: const Text("Quadratic Calculator")),
        options: null,
        limitEntries: const ["a", "b", "c"],
        resultContent: (List<String> list, Set<dynamic>? selectedValues,
            GlobalKey<FormBuilderState> formKey) {
          if (formKey.currentState?.isValid ?? false) {
            equation = QuadraticEquation(double.tryParse(list[0]) ?? 0,
                double.tryParse(list[1]) ?? 0, double.tryParse(list[2]) ?? 0);
          }

          return Column(
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
          );
        });
  }
}
