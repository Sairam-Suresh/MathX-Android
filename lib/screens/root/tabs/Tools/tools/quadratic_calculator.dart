import 'package:flutter/material.dart';
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
    return Tool();
  }
}
