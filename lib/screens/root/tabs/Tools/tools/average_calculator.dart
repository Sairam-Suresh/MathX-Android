import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/logic/tools/AverageLogic.dart';
import 'package:mathx_android/widgets/sizereporter.dart';

class AverageCalculatorPage extends StatefulWidget {
  const AverageCalculatorPage({Key? key}) : super(key: key);

  @override
  State<AverageCalculatorPage> createState() => _AverageCalculatorPageState();
}

class _AverageCalculatorPageState extends State<AverageCalculatorPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  String modeText = "";
  List<String> textFieldValues = ["0"];
  Size bottomSheetSize = Size(0, 0);

  Set<Averages> selectedModes = {
    Averages.mean,
    Averages.median,
    Averages.mode,
    Averages.standardDeviation
  };

  void addTextField() {
    setState(() {
      textFieldValues.add('');
    });
  }

  void deleteTextField() {
    setState(() {
      if (textFieldValues.isNotEmpty) {
        textFieldValues.removeLast();
      }
    });
  }

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
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Average",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  selectedModes.contains(Averages.mean)
                                      ? Expanded(
                                          child: ListTile(
                                            title: Text("Mean"),
                                            trailing: (_formKey.currentState
                                                        ?.isValid ??
                                                    false)
                                                ? Text(calculateMean(
                                                        textFieldValues
                                                            .map((e) =>
                                                                num.parse(e))
                                                            .toList())
                                                    .toString())
                                                : Text("--"),
                                          ),
                                        )
                                      : Container(),
                                  selectedModes.contains(Averages.median)
                                      ? Expanded(
                                          child: ListTile(
                                            title: Text("Median"),
                                            trailing: (_formKey.currentState
                                                        ?.isValid ??
                                                    false)
                                                ? Text(calculateMedian(
                                                        textFieldValues
                                                            .map((e) =>
                                                                num.parse(e))
                                                            .toList())
                                                    .toString())
                                                : Text("--"),
                                          ),
                                        )
                                      : Container(),
                                  selectedModes.contains(Averages.mode)
                                      ? Expanded(
                                          child: ListTile(
                                            title: Text("Mode"),
                                            trailing: (_formKey.currentState
                                                        ?.isValid ??
                                                    false)
                                                ? SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                    child: AutoSizeText(
                                                      modeText,
                                                      maxLines: 3,
                                                      minFontSize: 10,
                                                      maxFontSize: 20,
                                                      textAlign: TextAlign.end,
                                                    ))
                                                : Text("--"),
                                          ),
                                        )
                                      : Container(),
                                  selectedModes
                                          .contains(Averages.standardDeviation)
                                      ? Expanded(
                                          child: ListTile(
                                            title: Text("Standard Deviation"),
                                            trailing: (_formKey.currentState
                                                        ?.isValid ??
                                                    false)
                                                ? Text(
                                                    calculateStandardDeviation(
                                                            textFieldValues
                                                                .map((e) =>
                                                                    num.parse(
                                                                        e))
                                                                .toList())
                                                        .toString())
                                                : const Text("--"),
                                          ),
                                        )
                                      : Container(),

                                  // TODO: Implement results here
                                ],
                              )));
                    }),
              ),
        appBar: AppBar(title: const Text("Average Calculator"), actions: [
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: deleteTextField,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: addTextField,
          ),
        ]),
        body: KeyboardVisibilityBuilder(
            builder: (BuildContext context, bool keyboardVisible) {
          return Padding(
            padding: EdgeInsets.only(
                top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: SegmentedButton(
                      segments: const [
                        ButtonSegment(
                            value: Averages.mean, label: Text("Mean")),
                        ButtonSegment(
                            value: Averages.median, label: Text("Mdian")),
                        ButtonSegment(
                            value: Averages.mode, label: Text("Mode")),
                        ButtonSegment(
                            value: Averages.standardDeviation,
                            label: Text("Std Dev")),
                      ],
                      multiSelectionEnabled: true,
                      selected: selectedModes,
                      onSelectionChanged: (Set<Averages> newSelection) {
                        setState(() {
                          selectedModes = newSelection;
                        });
                      },
                    ),
                  ),
                ),
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
                              FormBuilderValidators.required()
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
