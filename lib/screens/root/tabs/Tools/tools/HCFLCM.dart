import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mathx_android/constants.dart';

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
  Map<String, dynamic> formValues = {};
  HCFLCM selectedMode = HCFLCM.HCF;

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, keyboardVisible) {
      return Scaffold(
        bottomSheet: keyboardVisible
            ? null
            : BottomSheet(
                onClosing: () {},
                builder: (BuildContext context) {
                  return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      child: Text("hello"));
                }),
        appBar: AppBar(title: const Text("HCF & LCM"), actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _formKey.currentState?.save();
              if (_formKey.currentState?.validate() == true) {
                setState(() {
                  textFields.add('');
                });
                print(textFields.length);
              }
            },
          ),
        ]),
        body: KeyboardVisibilityBuilder(
            builder: (BuildContext context, bool keyboardVisible) {
          return Padding(
            padding: EdgeInsets.only(
                top: 16.0,
                bottom: keyboardVisible
                    ? 16.0
                    : MediaQuery.of(context).size.height * 0.3 +
                        10 -
                        MediaQuery.of(context).viewInsets.bottom,
                left: 16.0,
                right: 16.0),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.height,
                      child: SegmentedButton(
                        segments: const [
                          ButtonSegment(value: HCFLCM.HCF, label: Text("HCF")),
                          ButtonSegment(value: HCFLCM.LCM, label: Text("LCM")),
                        ],
                        selected: {selectedMode},
                        onSelectionChanged: (Set<HCFLCM> newSelection) {
                          setState(() {
                            selectedMode = newSelection.first;
                          });
                        },
                      ),
                    ),
                  ),
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
                              if (_formKey.currentState?.validate() == true) {
                                setState(() {});
                              }
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
                  // const SizedBox(height: 16.0),
                  // ElevatedButton(
                  //   onPressed: textFields.length >= 2
                  //       ? () {
                  //           _formKey.currentState?.save();
                  //           if (_formKey.currentState?.validate() == true) {
                  //             // Retrieve all form field values
                  //             formValues = _formKey.currentState?.value ?? {};
                  //             // Process the form data as needed
                  //
                  //             showModalBottomSheet(
                  //                 context: context,
                  //                 builder: (context) {
                  //                   return BottomSheet(
                  //                     builder: (context) {
                  //                       return const Expanded(
                  //                         child: Padding(
                  //                             padding: EdgeInsets.all(
                  //                                 PADDING_FOR_MODAL_BOTTOM_SHEET),
                  //                             child: Text("hi")),
                  //                       );
                  //                     },
                  //                     onClosing: () {},
                  //                   );
                  //                 });
                  //           }
                  //         }
                  //       : null,
                  //   child: const Text('Get Results'),
                  // )
                ],
              ),
            ),
          );
        }),
      );
    });
  }
}
