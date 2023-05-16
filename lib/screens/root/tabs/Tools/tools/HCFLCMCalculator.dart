import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/logic/tools/HCFLCMLogic.dart';

class HCFLCMPage extends StatefulWidget {
  const HCFLCMPage({Key? key}) : super(key: key);

  @override
  State<HCFLCMPage> createState() => _HCFLCMPageState();
}

class _HCFLCMPageState extends State<HCFLCMPage> {
  HCFLCM selectedMode = HCFLCM.HCF;
  final _formKey = GlobalKey<FormBuilderState>();
  List<String> textFieldValues = [];

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
    // TODO: Need to make HCF have an option to have only prime numbers

    return Scaffold(
      bottomSheet: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: BottomSheet(
            onClosing: () {},
            builder: (BuildContext context) {
              return SizedBox(
                  // height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, left: 15, right: 15, bottom: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            selectedMode == HCFLCM.HCF
                                ? "Highest Common Factor"
                                : "Lowest Common Multiple",
                            style: const TextStyle(fontSize: 25),
                          ),
                          AutoSizeText(
                            textFieldValues.length >= 2 &&
                                    (_formKey.currentState?.isValid ?? false)
                                ? selectedMode == HCFLCM.HCF
                                    ? calculateHCFForMultiple(textFieldValues
                                            .map((e) => int.tryParse(e) ?? 0)
                                            .toList())
                                        .toString()
                                    : calculateLCMForMultiple(textFieldValues
                                            .map((e) => int.tryParse(e) ?? 0)
                                            .toList())
                                        .toString()
                                : "--",
                            style: const TextStyle(fontSize: 40),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          )
                        ],
                      )));
            }),
      ),
      appBar: AppBar(
        title: Text("HCF & LCM Calculator"),
        actions: [
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: deleteTextField,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: addTextField,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.height,
                child: SegmentedButton(
                  segments: const [
                    ButtonSegment(value: HCFLCM.HCF, label: Text("HCF")),
                    ButtonSegment(value: HCFLCM.LCM, label: Text("LCM")),
                  ],
                  selected: {selectedMode},
                  onSelectionChanged: (Set<HCFLCM> newSelection) {
                    setState(() {
                      selectedMode = newSelection.first;
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
                child: Column(
                  children: [
                    Expanded(
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

                    // This container is FAKE. It will HIDE BEHIND the main bottom sheet. It will only
                    // Act as a way to push the scrollview up so that it does not hide behind the bottomsheet
                    Container(
                      color: Colors.transparent,
                      child: Builder(builder: (BuildContext context) {
                        return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0, left: 15, right: 15, bottom: 30),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      selectedMode == HCFLCM.HCF
                                          ? "Highest Common Factor"
                                          : "Lowest Common Multiple",
                                      style: const TextStyle(fontSize: 25),
                                    ),
                                    AutoSizeText(
                                      textFieldValues.length >= 2 &&
                                              (_formKey.currentState?.isValid ??
                                                  false)
                                          ? selectedMode == HCFLCM.HCF
                                              ? calculateHCFForMultiple(
                                                      textFieldValues
                                                          .map((e) =>
                                                              int.tryParse(e) ??
                                                              0)
                                                          .toList())
                                                  .toString()
                                              : calculateLCMForMultiple(
                                                      textFieldValues
                                                          .map((e) =>
                                                              int.tryParse(e) ??
                                                              0)
                                                          .toList())
                                                  .toString()
                                          : "--",
                                      style: const TextStyle(fontSize: 40),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    )
                                  ],
                                )));
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
