import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/logic/tools/RandomiserLogic.dart';
import 'package:mathx_android/widgets/tooltemplate.dart';

class RandomiserPage extends StatefulWidget {
  const RandomiserPage({Key? key}) : super(key: key);

  @override
  State<RandomiserPage> createState() => _RandomiserPageState();
}

class _RandomiserPageState extends State<RandomiserPage> {
  RandomiserData randomiserData = RandomiserData();
  int? newValue;
  RandomiserPages page = RandomiserPages.occurences;
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
    return Tool(
      appbar: AppBar(title: Text("Randomiser")),
      resultContent: (_, __, ___) {
        return Text("Randomiser"); // Useless in this case
      },
      options: null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: FloatingActionButton(
        onPressed: (_formKey.currentState?.isValid ?? false)
            ? () {
                setState(() {
                  newValue = randomiserData.generateNewNumber(min!, max!);
                });
              }
            : null,
        disabledElevation: 0,
        child: Icon(Icons.plus_one),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [Icon(Icons.chevron_left), Text("Back")],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: !randomiserData.isResetToDefault()
                  ? () {
                      setState(() {
                        randomiserData.reset();
                        newValue = null;
                      });
                    }
                  : null,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [Icon(Icons.delete_forever), Text("Clear")],
              ),
            ),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () {
          if (_textFieldFocusNodeMax.hasFocus) {
            _textFieldFocusNodeMax.unfocus();
          }

          if (_textFieldFocusNodeMin.hasFocus) {
            _textFieldFocusNodeMin.unfocus();
          }
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Column(
                      children: [
                        Text(newValue != null ? newValue.toString() : "--",
                            style: TextStyle(fontSize: 50)),
                      ],
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
                          return Divider();
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
                          return Divider();
                        },
                      ),
              ),
              FormBuilder(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: FormBuilderTextField(
                        focusNode: _textFieldFocusNodeMin,
                        decoration:
                            InputDecoration(labelText: "Min Value (incl)"),
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
                        decoration:
                            InputDecoration(labelText: "Max Value (incl)"),
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
                                  errorText: "This must be bigger than min.")
                              : FormBuilderValidators.required(
                                  errorText: "Please fill this in.")
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SegmentedButton(
                    segments: [
                      ButtonSegment(
                          value: RandomiserPages.recent, label: Text("recent")),
                      ButtonSegment(
                          value: RandomiserPages.occurences,
                          label: Text("occurences")),
                    ],
                    selected: {page},
                    onSelectionChanged: (selection) {
                      setState(() {
                        page = selection.first;
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
