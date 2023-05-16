import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class Tooltemplate extends StatefulWidget {
  Tooltemplate(
      {Key? key,
      required this.appbar,
      this.segmentedButtonMultiSelect,
      required this.options,
      required this.bottomSheetContent})
      : super(key: key);

  late AppBar appBar;
  late bool? segmentedButtonMultiSelect;
  late Map<String, dynamic> options;

  late Function(List<String> list, Set<dynamic>? selectedValues,
      GlobalKey<FormBuilderState> formKey) bottomSheetContent;

  var appbar = AppBar(
    title: const Text("HCF & LCM Calculator"),
  );

  @override
  _TooltemplateState createState() => _TooltemplateState();
}

class _TooltemplateState extends State<Tooltemplate> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> textFieldValues = [""];

  var generatedAppBar = AppBar(
    title: const Text(""),
  );

  Set<dynamic> selectedValues = {};

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
  void initState() {
    selectedValues = {widget.options.entries.first.value};
    super.initState();
  }

  // INFO: Both the regular and the fake sheet are the same in terms of that they
  // Need to be wrapped in a Padding (In the fake sheet top padding is not needed)
  // and the regular one is needed. Then on top of that a SizedBox with full width using
  // MediaQuery is required.

  @override
  Widget build(BuildContext context) {
    generatedAppBar = AppBar(
      title: widget.appbar.title,
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
    );

    return Scaffold(
      key: _scaffoldKey,
      bottomSheet: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: BottomSheet(
            onClosing: () {},
            builder: (BuildContext context) {
              return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, left: 15, right: 15, bottom: 30),
                      child: widget.bottomSheetContent(
                          textFieldValues, selectedValues, _formKey)));
            }),
      ),
      appBar: generatedAppBar,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            widget.segmentedButtonMultiSelect != null
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.height,
                      child: SegmentedButton(
                        segments: widget.options.entries
                            .map((e) => ButtonSegment(
                                value: e.value, label: Text(e.key)))
                            .toList(),
                        selected: selectedValues,
                        multiSelectionEnabled:
                            widget.segmentedButtonMultiSelect!,
                        onSelectionChanged: (dynamic newSelection) {
                          setState(() {
                            selectedValues = newSelection;
                            print(selectedValues);
                          });
                        },
                      ),
                    ),
                  )
                : Container(),
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
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, left: 15, right: 15, bottom: 30),
                              child: widget.bottomSheetContent(
                                  textFieldValues, selectedValues, _formKey))),
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
