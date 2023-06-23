import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FixedTextFieldList extends StatefulWidget {
  const FixedTextFieldList(
      {super.key,
      required this.entries,
      required this.onChange,
      this.validators});

  final List<String> entries;
  final void Function(List<String?> values, bool isValid)? onChange;
  final String? Function(String?)? validators;

  @override
  State<FixedTextFieldList> createState() => _FixedTextFieldListState();
}

class _FixedTextFieldListState extends State<FixedTextFieldList> {
  final List<String?> _values = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _values.length = widget.entries.length;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: _formKey,
      child: Column(
        children: widget.entries.indexed
            .map((e) => TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _values[e.$1] = value;
                    });
                    widget.onChange?.call(
                        _values, _formKey.currentState?.validate() ?? false);
                  },
                  decoration: InputDecoration(
                    labelText: widget.entries[e.$1],
                  ),
                  keyboardType: TextInputType.number,
                  validator: widget.validators ??
                      FormBuilderValidators.compose([
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.required()
                      ]),
                ))
            .toList(),
      ),
    );
  }
}
