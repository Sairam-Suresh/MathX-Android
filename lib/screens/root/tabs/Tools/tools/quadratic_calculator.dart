import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mathx_android/widgets/tooltemplate.dart';

class QuadraticCalculator extends StatefulWidget {
  const QuadraticCalculator({Key? key}) : super(key: key);

  @override
  State<QuadraticCalculator> createState() => _QuadraticCalculatorState();
}

class _QuadraticCalculatorState extends State<QuadraticCalculator> {
  @override
  Widget build(BuildContext context) {
    return ToolTemplate(
        appbar: AppBar(title: const Text("Quadratic Calculator")),
        options: null,
        limitEntries: const ["a", "b", "c"],
        bottomSheetContent: (List<String> list, Set<dynamic>? selectedValues,
            GlobalKey<FormBuilderState> formKey) {});
  }
}
