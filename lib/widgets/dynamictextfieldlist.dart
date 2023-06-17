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

  @override
  void initState() {
    super.initState();
    _values.length = widget.count;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
                      print(_values);
                    });
                  },
                  decoration: InputDecoration(
                      labelText: "Number ${index + 1}",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _values.removeAt(index);
                            print(_values);
                          });
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      )),
                );
              }),
          IconButton(
            onPressed: () {
              setState(() {
                _values.add(null);
              });
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
