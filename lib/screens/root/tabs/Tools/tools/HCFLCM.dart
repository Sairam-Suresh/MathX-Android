import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/logic/tools/HCFLCMCalculator.dart';

class TextFieldData {
  final String text;
  final int index;

  TextFieldData({required this.text, required this.index});
}

class HCFLCMPage extends StatefulWidget {
  const HCFLCMPage({Key? key}) : super(key: key);

  @override
  State<HCFLCMPage> createState() => _HCFLCMPageState();
}

class _HCFLCMPageState extends State<HCFLCMPage> {
  GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  List<String> textFields = [];
  Map<String, dynamic> formValues = {};
  List<int> values = [];
  HCFLCM selectedMode = HCFLCM.HCF;

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, keyboardVisible) {
      return Scaffold(
        bottomSheet: keyboardVisible
            ? null
            : BottomSheet(
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
                              Text(
                                (_formKey.currentState?.isValid ?? false) &&
                                        values.isNotEmpty &&
                                        textFields.length >= 2
                                    ? selectedMode == HCFLCM.HCF
                                        ? calculateHCFForMultiple(values)
                                            .toString()
                                        : calculateLCMForMultiple(values)
                                            .toString()
                                    : "--",
                                style: const TextStyle(fontSize: 40),
                                textAlign: TextAlign.center,
                              )
                            ],
                          )));
                }),
        appBar: AppBar(title: const Text("HCF & LCM"), actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _formKey.currentState?.reset();
                _formKey.currentState?.save();

                values.clear();
                textFields.clear();
                formValues.clear();
                values.clear();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _formKey.currentState?.save();
              if (_formKey.currentState?.validate() == true) {
                setState(() {
                  textFields.add('');
                  formValues = _formKey.currentState?.value ?? {};
                  values =
                      formValues.values.map((e) => int.parse(e))?.toList() ??
                          [];
                });
              }
            },
          ),
        ]),
        body: KeyboardVisibilityBuilder(
            builder: (BuildContext context, bool keyboardVisible) {
          return Padding(
            padding: EdgeInsets.only(
                top: 16.0,
                bottom: keyboardVisible
                    ? 16.0
                    : MediaQuery.of(context).size.height * 0.3 +
                        10 -
                        MediaQuery.of(context).viewInsets.bottom,
                left: 16.0,
                right: 16.0),
            child: FormBuilder(
              key: _formKey,
              onChanged: () {
                if (_formKey.currentState?.validate() == true) {
                  formValues =
                      json.decode(json.encode(_formKey.currentState?.value)) ??
                          {};
                  values = formValues.values.map((e) => int.parse(e)).toList();

                  // print("-------------------------------");
                  // print(_formKey.currentState?.value);
                  // print("-------------------------------");
                  setState(() {});
                }
              },
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
                  Expanded(
                    child: ListView.builder(
                      itemCount: textFields.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: FormBuilderTextField(
                            name: 'text_$index',
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (value) {
                              _formKey.currentState?.save();
                              formValues = json.decode(json
                                      .encode(_formKey.currentState?.value)) ??
                                  {};
                              values = formValues.values
                                  .map((e) => int.parse(e))
                                  .toList();

                              print(formValues);
                              print(values);
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                labelText: 'Number ${index + 1}'),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.numeric(
                                  errorText: 'Please enter a valid number'),
                            ]),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      );
    });
  }
}
