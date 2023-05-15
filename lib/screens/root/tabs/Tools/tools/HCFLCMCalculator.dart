import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/logic/tools/HCFLCMLogic.dart';

class HCFLCMPage extends StatefulWidget {
  const HCFLCMPage({Key? key}) : super(key: key);

  @override
  State<HCFLCMPage> createState() => _HCFLCMPageState();
}

class _HCFLCMPageState extends State<HCFLCMPage> {
  HCFLCM selectedMode = HCFLCM.HCF;

  final _formKey = GlobalKey<FormBuilderState>();
  List<String> textFieldValues = [];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Size bottomSheetSize = Size(0, 0);

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
  Widget build(BuildContext context) {
    // TODO: Need to make HCF have an option to have only prime numbers

    return KeyboardVisibilityBuilder(builder: (context, visible) {
      return Scaffold(
        bottomSheet: !visible
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                child: BottomSheet(
                    onClosing: () {},
                    enableDrag: false,
                    builder: (BuildContext context) {
                      return SizedBox(
                          // height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, left: 15, right: 15, bottom: 30),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    selectedMode == HCFLCM.HCF
                                        ? "Highest Common Factor"
                                        : "Lowest Common Multiple",
                                    style: const TextStyle(fontSize: 25),
                                  ),
                                  AutoSizeText(
                                    textFieldValues.length >= 2 &&
                                            (_formKey.currentState?.isValid ??
                                                false)
                                        ? selectedMode == HCFLCM.HCF
                                            ? calculateHCFForMultiple(
                                                    textFieldValues
                                                        .map((e) =>
                                                            int.tryParse(e) ??
                                                            0)
                                                        .toList())
                                                .toString()
                                            : calculateLCMForMultiple(
                                                    textFieldValues
                                                        .map((e) =>
                                                            int.tryParse(e) ??
                                                            0)
                                                        .toList())
                                                .toString()
                                        : "--",
                                    style: const TextStyle(fontSize: 40),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                  )
                                ],
                              )));
                    }),
              )
            : null,
        appBar: AppBar(
          title: Text("HCF & LCM Calculator"),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: addTextField,
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
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
                          itemCount: textFieldValues.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: FormBuilderTextField(
                                name: 'number_${index + 1}',
                                autovalidateMode: AutovalidateMode.always,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.integer(
                                    errorText: "Please enter an integer",
                                  ),
                                  FormBuilderValidators.required(
                                    errorText: "Please enter an integer",
                                  )
                                ]),
                                decoration: InputDecoration(
                                    // labelText: 'Number ${index + 1}',
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

                      Padding(
                        padding: EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: deleteTextField,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Delete Last Number"),
                              Icon(Icons.delete),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height -
                      //       bottomSheetSize.height * 0.95,
                      // )
                      !visible
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: BottomSheet(
                                  onClosing: () {},
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                        // height: MediaQuery.of(context).size.height * 0.3,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15,
                                                left: 15,
                                                right: 15,
                                                bottom: 30),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  selectedMode == HCFLCM.HCF
                                                      ? "Highest Common Factor"
                                                      : "Lowest Common Multiple",
                                                  style: const TextStyle(
                                                      fontSize: 25),
                                                ),
                                                AutoSizeText(
                                                  textFieldValues.length >= 2 &&
                                                          (_formKey.currentState
                                                                  ?.isValid ??
                                                              false)
                                                      ? selectedMode ==
                                                              HCFLCM.HCF
                                                          ? calculateHCFForMultiple(
                                                                  textFieldValues
                                                                      .map((e) =>
                                                                          int.tryParse(
                                                                              e) ??
                                                                          0)
                                                                      .toList())
                                                              .toString()
                                                          : calculateLCMForMultiple(
                                                                  textFieldValues
                                                                      .map((e) =>
                                                                          int.tryParse(
                                                                              e) ??
                                                                          0)
                                                                      .toList())
                                                              .toString()
                                                      : "--",
                                                  style: const TextStyle(
                                                      fontSize: 40),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                )
                                              ],
                                            )));
                                  }),
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

class SizeControlledWidget extends StatefulWidget {
  final Widget child;

  SizeControlledWidget({required this.child});

  @override
  _SizeControlledWidgetState createState() => _SizeControlledWidgetState();
}

class _SizeControlledWidgetState extends State<SizeControlledWidget> {
  final ValueNotifier<Size> sizeNotifier = ValueNotifier<Size>(Size.zero);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final desiredSize = sizeNotifier.value;
        final updatedChild = widget.child;

        return ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: desiredSize.width,
            minHeight: desiredSize.height,
          ),
          child: Builder(
            builder: (BuildContext context) {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                final currentSize = context.size!;
                if (sizeNotifier.value != currentSize) {
                  sizeNotifier.value = currentSize;
                }
              });
              return updatedChild;
            },
          ),
        );
      },
    );
  }
}
