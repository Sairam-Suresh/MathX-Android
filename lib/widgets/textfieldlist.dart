import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class TextFieldListController extends ChangeNotifier {
  // Define your controller properties and methods here

  // Example property
  final List<String> _textFieldValues = [""];
  List<String> get textFieldValues => _textFieldValues;

  // Example method
  void addNewField() {
    _textFieldValues.add("");
    notifyListeners(); // Notify listeners about the change
  }

  void removeLastField() {
    if (textFieldValues.isNotEmpty) {
      _textFieldValues.removeLast();
    }
    notifyListeners(); // Notify listeners about the change
  }
}

class TextFieldList extends StatefulWidget {
  TextFieldList(
      {Key? key,
      this.limitEntries,
      this.validators,
      this.onChange,
      required this.controller,
      required this.formKey})
      : super(key: key);

  late final Map<String, dynamic>? limitEntries;
  late final dynamic validators;
  late final TextFieldListController controller;
  late final void Function(List<String> values)? onChange;
  late final GlobalKey<FormBuilderState> formKey;

  @override
  State<TextFieldList> createState() => _TextFieldListState();
}

class _TextFieldListState extends State<TextFieldList> {
  TextEditingController controller = TextEditingController();

  void deleteTextField() {
    setState(() {
      widget.controller.removeLastField();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: widget.formKey,
      clearValueOnUnregister: true,
      child: ListView.builder(
        itemCount: widget.limitEntries == null
            ? widget.controller.textFieldValues.length
            : widget.limitEntries!.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FormBuilderTextField(
              // controller: widget.controller,
              name: widget.limitEntries == null
                  ? 'number_${index + 1}'
                  : (widget.limitEntries?.entries
                          .toList()
                          .elementAt(index)
                          .key ??
                      'number_${index + 1}'),
              keyboardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validators != null
                  ? widget.validators!
                  : FormBuilderValidators.compose([
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.required()
                    ]),
              decoration: InputDecoration(
                  labelText: widget.limitEntries == null
                      ? 'Number ${index + 1}'
                      : (widget.limitEntries?.entries
                              .toList()
                              .elementAt(index)
                              .key ??
                          'Number ${index + 1}'),
                  prefixIcon: widget.limitEntries == null &&
                          index == widget.controller.textFieldValues.length - 1
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              widget.controller.textFieldValues.removeLast();
                              widget.onChange
                                  ?.call(widget.controller.textFieldValues);
                            });
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        )
                      : null),
              onChanged: (value) {
                setState(() {
                  try {
                    widget.controller.textFieldValues[index] = value ?? "";
                  } catch (e) {
                    widget.controller.textFieldValues.add(value ?? "");
                  }
                  widget.onChange?.call(widget.controller.textFieldValues);
                });
              },
              // onReset: () {
              //   setState(() {});
              // },
            ),
          );
        },
      ),
    );
  }
}
