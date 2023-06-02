import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mathx_android/logic/tools/PythagorasTheoremLogic.dart';
import 'package:mathx_android/widgets/textfieldlist.dart';

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
  String modeText = "";
  bool isVisible = true;
  ScrollController scrollController = ScrollController();

  TextFieldListController controller = TextFieldListController();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  Widget? textFields;
  int index = 0;

  @override
  void initState() {
    super.initState();
    textFields = TextFieldList(
      controller: controller,
      formKey: formKey,
      limitEntries: const {"a": null, "b": null, "c": null},
      validators: FormBuilderValidators.compose([
        FormBuilderValidators.numeric(errorText: "Please enter a valid number.")
      ]),
    );
  }

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
      limitEntries: const {"a": null, "b": null, "c": null},
      onChange: (_) {
        setState(() {});
        // formKey.currentState?.validate();
      },
      validators: FormBuilderValidators.compose([
        FormBuilderValidators.numeric(errorText: "Please enter a valid number.")
      ]),
    );

    return NotificationListener(
      onNotification: (notification) {
        if (notification is UserScrollNotification) {
          if (notification.direction == ScrollDirection.reverse && isVisible) {
            setState(() {
              isVisible = false;
            });
          } else if (notification.direction == ScrollDirection.forward &&
              !isVisible) {
            setState(() {
              isVisible = false;
            });
          }
        } else if (notification is ScrollEndNotification) {
          setState(() {
            isVisible = true;
          });
        }
        return false;
      },
      child: Scaffold(
          appBar: AppBar(title: const Text("Pyth Thrm Calculator")),
          body: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          buildResults(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: textFields!,
                          ),
                        ],
                      ))),
            ],
          )),
    );
  }

  Widget buildResults() {
    _noOfFieldsFilled = 0;

    for (String i in controller.textFieldValues) {
      _noOfFieldsFilled += (i == "") ? 0 : 1;
    }

    if (_noOfFieldsFilled == 2) {
      only2FieldsFilled = true;
    } else {
      only2FieldsFilled = false;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("Side A"),
              trailing:
                  (formKey.currentState?.isValid ?? false) && only2FieldsFilled
                      ? Text(
                          controller.textFieldValues.first != ""
                              ? controller.textFieldValues.first
                              : calculateSide(
                                      num.parse(controller.textFieldValues[2]),
                                      num.parse(controller.textFieldValues[1]))
                                  .toString(),
                          style: const TextStyle(fontSize: 20),
                        )
                      : const Text("--"),
            ),
            ListTile(
              title: const Text("Side B"),
              trailing:
                  (formKey.currentState?.isValid ?? false) && only2FieldsFilled
                      ? Text(
                          controller.textFieldValues[1] != ""
                              ? controller.textFieldValues[1]
                              : calculateSide(
                                      num.parse(controller.textFieldValues[2]),
                                      num.parse(controller.textFieldValues[0]))
                                  .toString(),
                          style: const TextStyle(fontSize: 20),
                        )
                      : const Text("--"),
            ),
            ListTile(
              title: const Text("Side C"),
              trailing:
                  (formKey.currentState?.isValid ?? false) && only2FieldsFilled
                      ? Text(
                          controller.textFieldValues.last != ""
                              ? controller.textFieldValues.last
                              : calculateHypotenuse(
                                      num.parse(controller.textFieldValues[0]),
                                      num.parse(controller.textFieldValues[1]))
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
        ),
      ),
    );
  }
}
