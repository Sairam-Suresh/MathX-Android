import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class Tool extends StatefulWidget {
  const Tool(
      {Key? key,
      this.appbar,
      required this.options,
      required this.resultContent,
      this.limitEntries,
      this.validatorComposer,
      this.child})
      : super(key: key);

  final Map<String, dynamic>? options;

  final Function(List<String> list, dynamic selectedValues,
      GlobalKey<FormBuilderState> formKey) resultContent;
  final AppBar? appbar;

  final List? limitEntries;
  final dynamic validatorComposer;

  final Widget? child;

  @override
  _ToolState createState() => _ToolState();
}

class _ToolState extends State<Tool> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> textFieldValues = [];

  AppBar? generatedAppBar = AppBar(
    title: const Text(""),
  );

  dynamic selectedValues;

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
    if (widget.limitEntries != null) {
      for (String _ in widget.limitEntries!) {
        textFieldValues.add("");
      }
    } else {
      textFieldValues = ["", ""];
    }
    setState(() {
      selectedValues = widget.options?.values.first;
    });
    super.initState();
  }

  // INFO: Both the regular and the fake sheet are the same in terms of that they
  // Need to be wrapped in a Padding (In the fake sheet top padding is not needed)
  // and the regular one is needed. Then on top of that a SizedBox with full width using
  // MediaQuery is required.

  final formKeys = <String, GlobalKey<FormBuilderState>>{};

  @override
  Widget build(BuildContext context) {
    generatedAppBar = widget.appbar != null
        ? AppBar(
            title: widget.appbar?.title,
            actions: [
              IconButton(
                onPressed: textFieldValues.length != 0
                    ? () {
                        setState(() {
                          textFieldValues.clear();
                        });
                      }
                    : null,
                icon: const Icon(Icons.delete_forever),
              )
            ],
            bottom: (widget.options != null)
                ? TabBar(
                    tabs:
                        widget.options!.keys.map((e) => Tab(text: e)).toList(),
                    onTap: (index) {
                      setState(() {
                        selectedValues =
                            widget.options!.values.elementAt(index);
                      });
                    },
                  )
                : null,
          )
        : null;

    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return GestureDetector(
        onTap: () {
          final currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: widget.child == null
            ? (widget.options != null)
                ? DefaultTabController(
                    initialIndex: 0,
                    length: widget.options!.length,
                    child: buildScaffold(context),
                  )
                : buildScaffold(context)
            : widget.child,
      );
    });
  }

  // Scaffold buildScaffold(BuildContext context) {
  //   return Scaffold(
  //       key: _scaffoldKey,
  //       appBar: generatedAppBar,
  //       floatingActionButton:
  //           widget.limitEntries == null && widget.child == null
  //               ? FloatingActionButton(
  //                   onPressed: () {
  //                     addTextField();
  //                   },
  //                   child: const Icon(Icons.add),
  //                 )
  //               : null,
  //       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
  //       body: Padding(
  //         padding: const EdgeInsets.all(10),
  //         child: FormBuilder(
  //           key: _formKey,
  //           clearValueOnUnregister: true,
  //           onChanged: () {
  //             print(textFieldValues);
  //           },
  //           child: SingleChildScrollView(
  //             child: Column(
  //               children: [
  //                 ListView.builder(
  //                   itemCount: widget.limitEntries == null
  //                       ? textFieldValues.length
  //                       : widget.limitEntries!.length,
  //                   shrinkWrap: true,
  //                   physics: NeverScrollableScrollPhysics(),
  //                   itemBuilder: (BuildContext context, int index) {
  //                     return Padding(
  //                       padding: const EdgeInsets.only(bottom: 10),
  //                       child: FormBuilderTextField(
  //                         name: widget.limitEntries == null
  //                             ? 'number_${index + 1}'
  //                             : widget.limitEntries![index],
  //                         keyboardType: TextInputType.number,
  //                         autovalidateMode: AutovalidateMode.onUserInteraction,
  //                         validator: widget.validatorComposer != null
  //                             ? widget.validatorComposer!
  //                             : FormBuilderValidators.compose([
  //                                 FormBuilderValidators.numeric(),
  //                                 FormBuilderValidators.required()
  //                               ]),
  //                         decoration: InputDecoration(
  //                             labelText: widget.limitEntries == null
  //                                 ? 'Number ${index + 1}'
  //                                 : widget.limitEntries![index],
  //                             suffixIcon: widget.limitEntries == null &&
  //                                     index == textFieldValues.length - 1
  //                                 ? IconButton(
  //                                     onPressed: () {
  //                                       deleteTextField();
  //                                     },
  //                                     icon: Icon(Icons.delete),
  //                                   )
  //                                 : null),
  //                         onChanged: (value) {
  //                           setState(() {
  //                             textFieldValues[index] = value ?? "";
  //                           });
  //                         },
  //                       ),
  //                     );
  //                   },
  //                 ),
  //                 Card(
  //                   child: SizedBox(
  //                       width: MediaQuery.of(context).size.width,
  //                       child: Padding(
  //                           padding: const EdgeInsets.symmetric(
  //                               horizontal: 10, vertical: 10),
  //                           child: widget.resultContent(
  //                               textFieldValues, selectedValues, _formKey))),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ));
  // }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: generatedAppBar,
      floatingActionButton:
          (widget.limitEntries == null && widget.child == null)
              ? FloatingActionButton(
                  onPressed: () {
                    addTextField();
                  },
                  child: const Icon(Icons.add),
                )
              : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: TabBarView(
          children: widget.options!.entries.map((entry) {
            final tabKey = entry.key;
            final tabValues = entry.value;
            final formKey = formKeys[tabKey] ?? GlobalKey<FormBuilderState>();
            formKeys[tabKey] = formKey;

            return FormBuilder(
              key: formKey,
              clearValueOnUnregister: true,
              onChanged: () {
                print(textFieldValues);
              },
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: widget.limitEntries == null
                        ? textFieldValues.length
                        : widget.limitEntries!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: FormBuilderTextField(
                          key: ValueKey('${tabKey}_textField_$index'),
                          name: widget.limitEntries == null
                              ? 'number_${index + 1}'
                              : widget.limitEntries![index],
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                    index == textFieldValues.length - 1
                                ? IconButton(
                                    onPressed: () {
                                      deleteTextField();
                                    },
                                    icon: Icon(Icons.delete),
                                  )
                                : null,
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
                  Card(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: widget.resultContent(
                          textFieldValues,
                          tabValues,
                          formKey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
