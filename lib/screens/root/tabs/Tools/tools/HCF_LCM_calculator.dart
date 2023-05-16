import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/logic/tools/HCFLCMLogic.dart';
import 'package:mathx_android/widgets/tooltemplate.dart';

class HCFLCMPage extends StatefulWidget {
  const HCFLCMPage({Key? key}) : super(key: key);

  @override
  State<HCFLCMPage> createState() => _HCFLCMPageState();
}

class _HCFLCMPageState extends State<HCFLCMPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: Need to make HCF have an option to have only prime numbers

    return ToolTemplate(
        appbar: AppBar(title: const Text("HCF/LCM Calculator")),
        segmentedButtonMultiSelect: false,
        options: const {"HCF": HCFLCM.HCF, "LCM": HCFLCM.LCM},
        bottomSheetContent: (List<String> list, Set<dynamic>? selectedValues,
            GlobalKey<FormBuilderState> formKey) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                (selectedValues?.isNotEmpty ?? false) &&
                        selectedValues?.first == HCFLCM.HCF
                    ? "Highest Common Factor"
                    : "Lowest Common Multiple",
                style: const TextStyle(fontSize: 25),
              ),
              AutoSizeText(
                list.length >= 2 && (formKey.currentState?.isValid ?? false)
                    ? selectedValues?.first == HCFLCM.HCF
                        ? calculateHCFForMultiple(
                                list.map((e) => int.tryParse(e) ?? 0).toList())
                            .toString()
                        : calculateLCMForMultiple(
                                list.map((e) => int.tryParse(e) ?? 0).toList())
                            .toString()
                    : "--",
                style: const TextStyle(fontSize: 30),
              ),
              list.length < 2
                  ? const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.warning_amber),
                            SizedBox(width: 10),
                            AutoSizeText(
                                "Please ensure that there are at least 2 numbers",
                                maxLines: 2,
                                textAlign: TextAlign.justify),
                          ],
                        ),
                      ),
                    )
                  : !(formKey.currentState?.isValid ?? false)
                      ? Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.warning_amber),
                              SizedBox(width: 10),
                              AutoSizeText(
                                  "Please ensure all numbers are filled and valid.",
                                  maxLines: 2,
                                  textAlign: TextAlign.justify),
                            ],
                          ),
                        )
                      : Container(),
            ],
          );
        });
  }
}
