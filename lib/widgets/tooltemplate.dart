import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ToolTemplate extends StatefulWidget {
  ToolTemplate(
      {Key? key,
      required this.appbar,
      this.segmentedButtonMultiSelect,
      required this.options,
      required this.bottomSheetContent,
      this.limitEntries,
      this.validatorComposer})
      : super(key: key);

  // Generic Arguments
  late bool? segmentedButtonMultiSelect;
  late Map<String, dynamic>? options;
  late Function(List<String> list, Set<dynamic>? selectedValues,
      GlobalKey<FormBuilderState> formKey) bottomSheetContent;
  late AppBar appbar;

  late List? limitEntries;
  late dynamic validatorComposer;

  @override
  _ToolTemplateState createState() => _ToolTemplateState();
}

class _ToolTemplateState extends State<ToolTemplate> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> textFieldValues = [];

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
    selectedValues =
        widget.options != null ? {widget.options!.entries.first.value} : {};

    if (widget.limitEntries != null) {
      for (String _ in widget.limitEntries!) {
        textFieldValues.add("");
      }
    }
    setState(() {});
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
      actions: widget.limitEntries == null
          ? [
              IconButton(
                icon: const Icon(Icons.undo),
                onPressed: deleteTextField,
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: addTextField,
              ),
            ]
          : null,
    );

    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        key: _scaffoldKey,
        bottomSheet: !isKeyboardVisible
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                child: BottomSheet(
                    onClosing: () {},
                    enableDrag: false,
                    builder: (BuildContext context) {
                      return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, left: 15, right: 15, bottom: 30),
                              child: widget.bottomSheetContent(
                                  textFieldValues, selectedValues, _formKey)));
                    }),
              )
            : null,
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
                          segments: widget.options!.entries
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
                          itemCount: widget.limitEntries == null
                              ? textFieldValues.length
                              : widget.limitEntries!.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: FormBuilderTextField(
                                name: widget.limitEntries == null
                                    ? 'number_${index + 1}'
                                    : widget.limitEntries![index],
                                autovalidateMode: AutovalidateMode.always,
                                validator: widget.validatorComposer != null
                                    ? widget.validatorComposer!
                                    : FormBuilderValidators.compose([
                                        FormBuilderValidators.numeric(),
                                        FormBuilderValidators.required()
                                      ]),
                                decoration: InputDecoration(
                                  labelText: widget.limitEntries == null
                                      ? 'Number ${index + 1}'
                                      : widget.limitEntries![index],
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
                      !isKeyboardVisible
                          ? Container(
                              color: Colors.transparent,
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          left: 15,
                                          right: 15,
                                          bottom: 30),
                                      child: widget.bottomSheetContent(
                                          textFieldValues,
                                          selectedValues,
                                          _formKey))),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
