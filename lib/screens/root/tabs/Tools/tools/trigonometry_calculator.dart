import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mathx_android/logic/tools/TrigonometryCalculatorLogic.dart';
import 'package:mathx_android/widgets/textfieldlist.dart';

class TrigonometryCalculatorPage extends StatefulWidget {
  @override
  _TrigonometryCalculatorPageState createState() =>
      _TrigonometryCalculatorPageState();
}

class _TrigonometryCalculatorPageState
    extends State<TrigonometryCalculatorPage> {
  TextFieldListController controller = TextFieldListController();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

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
          TextFieldList(
            controller: controller,
            formKey: formKey,
            limitEntries: const {
              "Side A (Opposite)": 0,
              "Side B (Adjacent)": 0,
              "Side C (Hypotenuse)": 0
            },
            onChange: (_) {
              setState(() {});
            },
            validators: FormBuilderValidators.compose([
              FormBuilderValidators.numeric(
                  errorText: "Please enter a valid number."),
              FormBuilderValidators.min(1,
                  errorText: "Please enter a number greater than 0")
            ]),
          )
        ]),
      ),
    );
  }

  Widget buildResult() {
    int _noOfFieldsFilled = 0;
    bool moreThan2FieldsFilled = false;

    for (String i in controller.textFieldValues) {
      _noOfFieldsFilled += (i == "") ? 0 : 1;
    }

    if (_noOfFieldsFilled >= 2) {
      moreThan2FieldsFilled = true;
    } else {
      moreThan2FieldsFilled = false;
    }

    Map<TrigonometryResultKey, String> result = calculateAngleX(
        sideA: double.tryParse(
                controller.textFieldValues.elementAtOrNull(0) ?? "") ??
            0,
        sideB: double.tryParse(
                (controller.textFieldValues.elementAtOrNull(1) ?? "")) ??
            0,
        sideC: double.tryParse(
                (controller.textFieldValues.elementAtOrNull(2) ?? "")) ??
            0,
        angleUnitSelection: AngleUnit.degrees);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            (formKey.currentState?.validate() ?? false) && moreThan2FieldsFilled
                ? Center(
                    child: Math.tex(
                      "x° = ${result[TrigonometryResultKey.equation]} = ${result[TrigonometryResultKey.answer]}",
                    ),
                  )
                : Center(
                    child: Math.tex("x° = --"),
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
