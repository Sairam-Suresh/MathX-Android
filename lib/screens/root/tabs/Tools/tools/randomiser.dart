import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/logic/tools/RandomiserLogic.dart';

class RandomiserPage extends StatefulWidget {
  const RandomiserPage({Key? key}) : super(key: key);

  @override
  State<RandomiserPage> createState() => _RandomiserPageState();
}

class _RandomiserPageState extends State<RandomiserPage> {
  RandomiserData randomiserData = RandomiserData();
  int? newValue;
  RandomiserPages page = RandomiserPages.recent;
  final _formKey = GlobalKey<FormBuilderState>();

  final FocusNode _textFieldFocusNodeMin = FocusNode();
  final FocusNode _textFieldFocusNodeMax = FocusNode();

  int? min = 0;
  int? max = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textFieldFocusNodeMin.dispose();
    _textFieldFocusNodeMax.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Randomiser"),
          bottom: TabBar(
            tabs: [
              const Tab(
                child: Text("Recent"),
              ),
              const Tab(
                child: Text("Occurrences"),
              )
            ],
            onTap: (index) {
              setState(() {
                page = RandomiserPages.values[index];
              });
            },
          ),
        ),
        body: GestureDetector(
          onTap: () {
            if (_textFieldFocusNodeMax.hasFocus) {
              _textFieldFocusNodeMax.unfocus();
            }

            if (_textFieldFocusNodeMin.hasFocus) {
              _textFieldFocusNodeMin.unfocus();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                        child: InkWell(
                      onTap: (_formKey.currentState?.isValid ?? false)
                          ? () {
                              setState(() {
                                newValue = randomiserData.generateNewNumber(
                                    min!, max!);
                              });
                            }
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: Column(
                          children: [
                            Text(newValue != null ? newValue.toString() : "--",
                                style: const TextStyle(fontSize: 50)),
                            (_formKey.currentState?.isValid ?? false)
                                ? const AutoSizeText(
                                    "Tap to generate a new number",
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  )
                                : const AutoSizeText(
                                    "Please Ensure Min and Max numbers are filled in",
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  )
                          ],
                        ),
                      ),
                    ))),
                Expanded(
                  child: page == RandomiserPages.recent
                      ? ListView.separated(
                          itemCount: randomiserData.getHistory().length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(randomiserData
                                  .getHistoryByIndex(index)
                                  .toString()),
                            );
                          },
                          separatorBuilder: (context, _) {
                            return const Divider();
                          },
                        )
                      : ListView.separated(
                          itemCount: randomiserData.getOccurrences().length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(randomiserData
                                  .getOccurrencesByIndex(index)["number"]
                                  .toString()),
                              trailing: Text(
                                  "${randomiserData.getOccurrencesByIndex(index)["count"]} (${randomiserData.getOccurrencesByIndex(index)["percentage"]}%)"),
                            );
                          },
                          separatorBuilder: (context, _) {
                            return const Divider();
                          },
                        ),
                ),
                FormBuilder(
                  key: _formKey,
                  child: SafeArea(
                    child: Row(
                      children: [
                        Expanded(
                          child: FormBuilderTextField(
                            focusNode: _textFieldFocusNodeMin,
                            decoration: const InputDecoration(
                                labelText: "Min Value (incl)"),
                            onChanged: (value) {
                              setState(() {
                                min = int.tryParse(value ?? "");
                              });
                            },
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: "Please fill this in."),
                              FormBuilderValidators.numeric(
                                  errorText: "Please ensure this is numeric.")
                            ]),
                            keyboardType: TextInputType.number,
                            autovalidateMode: AutovalidateMode.always,
                            name: 'min',
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: FormBuilderTextField(
                            focusNode: _textFieldFocusNodeMax,
                            decoration: const InputDecoration(
                                labelText: "Max Value (incl)"),
                            name: "max",
                            onChanged: (value) {
                              setState(() {
                                max = int.tryParse(value ?? "");
                              });
                            },
                            keyboardType: TextInputType.number,
                            autovalidateMode: AutovalidateMode.always,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: "Please fill this in."),
                              FormBuilderValidators.numeric(
                                  errorText: "Please ensure this is numeric."),
                              min != null
                                  ? FormBuilderValidators.min(min!,
                                      inclusive: false,
                                      errorText:
                                          "This must be bigger than min.")
                                  : FormBuilderValidators.required(
                                      errorText: "Please fill this in.")
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(top: 20, bottom: 10),
                //   child: SizedBox(
                //     width: MediaQuery.of(context).size.width,
                //     child: SegmentedButton(
                //       segments: [
                //         ButtonSegment(
                //             value: RandomiserPages.recent,
                //             label: Text("recent")),
                //         ButtonSegment(
                //             value: RandomiserPages.occurences,
                //             label: Text("occurences")),
                //       ],
                //       selected: {page},
                //       onSelectionChanged: (selection) {
                //         setState(() {
                //           page = selection.first;
                //         });
                //       },
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
