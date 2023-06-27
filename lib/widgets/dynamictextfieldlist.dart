import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class DynamicTextFieldList extends StatefulWidget {
  const DynamicTextFieldList(
      {super.key,
      required this.count,
      this.onChange,
      this.validators,
      this.nameBuilder});

  final int count;
  final void Function(List<String?> values, bool isValid, int count)? onChange;
  final String? Function(String?)? validators;
  final String Function(int length, int index)? nameBuilder;

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
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: _values.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final TextEditingController controller = TextEditingController();

            controller.text = _values[index] ?? "";
            controller.selection = TextSelection.fromPosition(
                TextPosition(offset: controller.text.length));
            return Animate(
              effects: [SlideEffect(duration: 100.milliseconds)],
              child: TextFormField(
                validator: widget.validators ??
                    FormBuilderValidators.compose([
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.required()
                    ]),
                keyboardType: TextInputType.number,
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
                    labelText: widget.nameBuilder == null
                        ? "Number ${index + 1}"
                        : widget.nameBuilder?.call(_values.length, index),
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
              ),
            );
          }),
    );
  }
}
