import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class DynamicTextFieldList extends StatefulWidget {
  const DynamicTextFieldList(
      {super.key, required this.count, this.onChange, this.validators});

  final int count;
  final void Function(List<String?> values, bool isValid, int count)? onChange;
  final String? Function(String?)? validators;

  @override
  State<DynamicTextFieldList> createState() => _DynamicTextFieldListState();
}

class _DynamicTextFieldListState extends State<DynamicTextFieldList> {
  final List<String?> _values = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _values.length = widget.count;
  }

  @override
  Widget build(BuildContext context) {
    _values.length = widget.count;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: _values.length,
              itemBuilder: (context, index) {
                final TextEditingController controller =
                    TextEditingController();

                controller.text = _values[index] ?? "";
                controller.selection = TextSelection.fromPosition(
                    TextPosition(offset: controller.text.length));

                return TextFormField(
                  validator: widget.validators ??
                      FormBuilderValidators.compose([
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.required()
                      ]),
                  controller: controller,
                  onChanged: (value) {
                    setState(() {
                      _values[index] = value;
                      widget.onChange?.call(
                          _values,
                          _formKey.currentState?.validate() ?? false,
                          widget.count);
                    });
                  },
                  decoration: InputDecoration(
                      labelText: "Number ${index + 1}",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _values.removeAt(index);
                            widget.onChange?.call(
                                _values,
                                _formKey.currentState?.validate() ?? false,
                                widget.count - 1);
                          });
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      )),
                );
              })
        ],
      ),
    );
  }
}
