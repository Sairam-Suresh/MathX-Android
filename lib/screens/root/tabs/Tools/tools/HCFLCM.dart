import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class TextFieldData {
  final String text;
  final int index;

  TextFieldData({required this.text, required this.index});
}

class HCFLCMPage extends StatefulWidget {
  const HCFLCMPage({Key? key}) : super(key: key);

  @override
  State<HCFLCMPage> createState() => _HCFLCMPageState();
}

class _HCFLCMPageState extends State<HCFLCMPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  List<String> textFields = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("HCF & LCM"), actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _formKey.currentState?.save();
              if (_formKey.currentState?.validate() == true) {
                setState(() {
                  textFields.add('');
                });
              }
            },
          ),
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: textFields.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: FormBuilderTextField(
                        name: 'text_$index',
                        onChanged: (value) {
                          _formKey.currentState?.save();
                          if (_formKey.currentState?.validate() == true) {}
                        },
                        decoration: InputDecoration(
                          labelText: 'Text ${index + 1}',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                textFields.removeAt(index);
                              });
                            },
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(
                              errorText: 'Please enter a valid number'),
                        ]),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState?.save();
                  if (_formKey.currentState?.validate() == true) {
                    // Retrieve all form field values
                    Map<String, dynamic> formValues =
                        _formKey.currentState?.value ?? {};
                    // Process the form data as needed
                    print(formValues);
                  }
                },
                child: const Text('Get Results'),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
