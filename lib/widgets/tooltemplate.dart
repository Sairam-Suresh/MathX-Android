import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class Tool extends StatefulWidget {
  const Tool(
      {Key? key,
      required this.appbar,
      this.segmentedButtonMultiSelect,
      required this.options,
      required this.resultContent,
      this.limitEntries,
      this.validatorComposer,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.bottomNavigationBar,
      this.child})
      : super(key: key);

  // Generic Arguments
  final bool? segmentedButtonMultiSelect;

  final Map<String, dynamic>? options;

  final Function(List<String> list, Set<dynamic>? selectedValues,
      GlobalKey<FormBuilderState> formKey) resultContent;
  final AppBar appbar;

  final List? limitEntries;
  final dynamic validatorComposer;

  final Widget? child;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;

  @override
  _ToolState createState() => _ToolState();
}

class _ToolState extends State<Tool> {
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
    } else {
      textFieldValues = ["", ""];
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
      automaticallyImplyLeading: false,
    );

    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return GestureDetector(
        onTap: () {
          final currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: generatedAppBar,
          floatingActionButton: widget.floatingActionButton == null
              ? widget.limitEntries == null && widget.child == null
                  ? FloatingActionButton(
                      onPressed: () {
                        addTextField();
                      },
                      child: const Icon(Icons.add),
                    )
                  : null
              : widget.floatingActionButton!,
          floatingActionButtonLocation:
              widget.floatingActionButtonLocation == null
                  ? FloatingActionButtonLocation.endContained
                  : widget.floatingActionButtonLocation!,
          bottomNavigationBar: widget.bottomNavigationBar == null
              ? BottomAppBar(
                  child: widget.limitEntries == null && widget.child == null
                      ? Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.chevron_left),
                                      Text("Back")
                                    ],
                                  ),
                                )),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: ElevatedButton(
                                  onPressed: textFieldValues.length != 0
                                      ? () {
                                          setState(() {
                                            textFieldValues.clear();
                                          });
                                        }
                                      : null,
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.delete_forever),
                                      Text("Clear Values")
                                    ],
                                  ),
                                )),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.chevron_left),
                                Text("Back")
                              ],
                            ),
                          )),
                )
              : widget.bottomNavigationBar!,
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {},
          //   child: Icon(Icons.add),
          // ),
          body: widget.child == null
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Card(
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: widget.resultContent(textFieldValues,
                                    selectedValues, _formKey))),
                      ),
                      FormBuilder(
                        key: _formKey,
                        clearValueOnUnregister: true,
                        onChanged: () {
                          print(textFieldValues);
                        },
                        child: Expanded(
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
                                  keyboardType: TextInputType.number,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
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
                                      suffixIcon: widget.limitEntries == null &&
                                              index ==
                                                  textFieldValues.length - 1
                                          ? IconButton(
                                              onPressed: () {
                                                deleteTextField();
                                              },
                                              icon: Icon(Icons.delete),
                                            )
                                          : null),
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
                      widget.segmentedButtonMultiSelect != null
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
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
                    ],
                  ),
                )
              : widget.child!,
        ),
      );
    });
  }
}
