import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mathx_android/logic/tools/PythagorasTheoremLogic.dart';
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
    return Tool(
        appbar: AppBar(title: const Text("Pythagoras Theorem")),
        validatorComposer: FormBuilderValidators.compose([
          FormBuilderValidators.numeric(
              errorText: "Please enter a valid number.")
        ]),
        options: null,
        limitEntries: const [
          "Side A (Normal)",
          "Side B (Normal)",
          "Side C (Hypotenuse)"
        ],
        resultContent: (List<String> list, Set<dynamic>? selectedValues,
            GlobalKey<FormBuilderState> formKey) {
          _noOfFieldsFilled = 0;

          for (String i in list) {
            _noOfFieldsFilled += (i == "") ? 0 : 1;
          }

          if (_noOfFieldsFilled == 2) {
            only2FieldsFilled = true;
          } else {
            only2FieldsFilled = false;
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("Side A"),
                trailing: (formKey.currentState?.isValid ?? false) &&
                        only2FieldsFilled
                    ? Text(
                        list.first != ""
                            ? list.first
                            : calculateSide(
                                    num.parse(list[2]), num.parse(list[1]))
                                .toString(),
                        style: const TextStyle(fontSize: 20),
                      )
                    : const Text("--"),
              ),
              ListTile(
                title: const Text("Side B"),
                trailing: (formKey.currentState?.isValid ?? false) &&
                        only2FieldsFilled
                    ? Text(
                        list[1] != ""
                            ? list[1]
                            : calculateSide(
                                    num.parse(list[2]), num.parse(list[0]))
                                .toString(),
                        style: const TextStyle(fontSize: 20),
                      )
                    : const Text("--"),
              ),
              ListTile(
                title: const Text("Side C"),
                trailing: (formKey.currentState?.isValid ?? false) &&
                        only2FieldsFilled
                    ? Text(
                        list.last != ""
                            ? list.last
                            : calculateHypotenuse(
                                    num.parse(list[0]), num.parse(list[1]))
                                .toString(),
                        style: const TextStyle(fontSize: 20),
                      )
                    : const Text("--"),
              ),
              _noOfFieldsFilled > 2
                  ? const Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.warning_amber),
                          SizedBox(width: 10),
                          Text("Please only enter 2 values"),
                        ],
                      ),
                    )
                  : _noOfFieldsFilled < 2
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
          );
        });
  }
}
