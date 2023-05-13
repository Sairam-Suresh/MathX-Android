import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mathx_android/logic/tools/AverageLogic.dart';
import 'package:mathx_android/widgets/sizereporter.dart';

class PythagorasTheoremCalculatorPage extends StatefulWidget {
  const PythagorasTheoremCalculatorPage({Key? key}) : super(key: key);

  @override
  State<PythagorasTheoremCalculatorPage> createState() =>
      _PythagorasTheoremCalculatorPageState();
}

class _PythagorasTheoremCalculatorPageState
    extends State<PythagorasTheoremCalculatorPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  String modeText = "";
  List<String> textFieldValues = ["0", "0", "0"];
  Size bottomSheetSize = Size(0, 0);

  @override
  Widget build(BuildContext context) {
    // calculateMode(textFieldValues
    //     .map((e) => num.parse(e))
    //     .toList())
    //     .join(", ")

    modeText = "";

    calculateMode(textFieldValues.map((e) => num.tryParse(e) ?? 0).toList())
        .forEach((key, value) {
      setState(() {
        modeText += " $key($value)";
      });
    });

    return KeyboardVisibilityBuilder(builder: (context, keyboardVisible) {
      return Scaffold(
        bottomSheet: keyboardVisible
            ? null
            : SizeReporter(
                onSizeChanged: (size) {
                  bottomSheetSize = size;
                },
                child: BottomSheet(
                    onClosing: () {},
                    builder: (BuildContext context) {
                      return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, left: 15, right: 15, bottom: 20),
                              child: Text("hello")));
                    }),
              ),
        appBar: AppBar(title: const Text("Average Calculator")),
        body: KeyboardVisibilityBuilder(
            builder: (BuildContext context, bool keyboardVisible) {
          return Padding(
            padding: EdgeInsets.only(
                top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
            child: Column(
              children: [
                FormBuilder(
                  key: _formKey,
                  clearValueOnUnregister: true,
                  onChanged: () {
                    print(textFieldValues);
                  },
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: textFieldValues.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: FormBuilderTextField(
                            name: 'number_${index + 1}',
                            autovalidateMode: AutovalidateMode.always,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.numeric(),
                            ]),
                            decoration: InputDecoration(
                              labelText: 'Number ${index + 1}',
                            ),
                            onChanged: (value) {
                              setState(() {
                                textFieldValues[index] = value ?? "";
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
                !keyboardVisible
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height -
                            bottomSheetSize.height * 0.8,
                      )
                    : Container()
              ],
            ),
          );
        }),
      );
    });
  }
}
