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

    return Tooltemplate(
        appbar: AppBar(title: Text("HCF/LCM Calculator")),
        segmentedButtonMultiSelect: false,
        options: {"HCF": HCFLCM.HCF, "LCM": HCFLCM.LCM},
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
              )
            ],
          );
        });
  }
}
