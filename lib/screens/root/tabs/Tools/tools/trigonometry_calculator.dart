import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mathx_android/logic/tools/trigonometry_calculator_logic.dart';
import 'package:mathx_android/widgets/fixedtextfieldlist.dart';

class TrigonometryCalculatorPage extends StatefulWidget {
  const TrigonometryCalculatorPage({super.key});

  @override
  _TrigonometryCalculatorPageState createState() =>
      _TrigonometryCalculatorPageState();
}

class _TrigonometryCalculatorPageState
    extends State<TrigonometryCalculatorPage> {
  AngleUnit selectedUnit = AngleUnit.degrees;
  List<String?> values = [];
  bool isFormValid = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trigonometry Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          SizedBox(
              width: MediaQuery.of(context).size.width, child: buildResult()),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SegmentedButton<AngleUnit>(
                  segments: const [
                    ButtonSegment(
                      value: AngleUnit.degrees,
                      label: Text("Degrees"),
                    ),
                    ButtonSegment(
                      value: AngleUnit.radians,
                      label: Text("Radians"),
                    )
                  ],
                  showSelectedIcon: false,
                  selected: {selectedUnit},
                  multiSelectionEnabled: false,
                  onSelectionChanged: (value) {
                    setState(() {
                      selectedUnit = value.first;
                    });
                  }),
            ),
          ),
          FixedTextFieldList(
              entries: const [
                "Side A (Opposite)",
                "Side B (Adjacent)",
                "Side C (Hypotenuse)"
              ],
              onChange: (newValues, valid) {
                setState(() {
                  values = newValues;
                  isFormValid = valid;
                });
              },
              validators: FormBuilderValidators.compose([
                FormBuilderValidators.numeric(),
              ]))
        ]),
      ),
    );
  }

  Widget buildResult() {
    int noOfFieldsFilled = 0;
    bool moreThan2FieldsFilled = false;

    for (String? i in values) {
      noOfFieldsFilled += (i == "" || i == null) ? 0 : 1;
    }

    if (noOfFieldsFilled >= 2) {
      moreThan2FieldsFilled = true;
    } else {
      moreThan2FieldsFilled = false;
    }

    Map<TrigonometryResultKey, String> result = calculateAngleX(
        sideA: double.tryParse(values.elementAtOrNull(0) ?? "") ?? 0,
        sideB: double.tryParse((values.elementAtOrNull(1) ?? "")) ?? 0,
        sideC: double.tryParse((values.elementAtOrNull(2) ?? "")) ?? 0,
        angleUnitSelection: selectedUnit);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            isFormValid && moreThan2FieldsFilled
                ? Center(
                    child: Math.tex(
                        "x° = ${result[TrigonometryResultKey.equation]} = ${result[TrigonometryResultKey.answer]}",
                        textStyle: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .fontSize)),
                  )
                : Center(
                    child: Math.tex("x° = --",
                        textStyle: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .fontSize)),
                  ),
            !moreThan2FieldsFilled
                ? const Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.warning_amber),
                        SizedBox(width: 10),
                        Text("Please enter at least 2 values"),
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
