import 'package:flutter/material.dart';
import 'package:mathx_android/widgets/tooltemplate.dart';

class PythagorasTheoremCalculatorPage extends StatefulWidget {
  const PythagorasTheoremCalculatorPage({Key? key}) : super(key: key);

  @override
  State<PythagorasTheoremCalculatorPage> createState() =>
      _PythagorasTheoremCalculatorPageState();
}

class _PythagorasTheoremCalculatorPageState
    extends State<PythagorasTheoremCalculatorPage> {
  bool only2FieldsFilled = false;
  int _noOfFieldsFilled = 0;

  @override
  Widget build(BuildContext context) {
    return Tool();
  }
}
