import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mathx_android/logic/tools/AverageLogic.dart';
import 'package:mathx_android/widgets/textfieldlist.dart';

class AverageCalculatorPage extends StatefulWidget {
  const AverageCalculatorPage({Key? key}) : super(key: key);

  @override
  State<AverageCalculatorPage> createState() => _AverageCalculatorPageState();
}

class _AverageCalculatorPageState extends State<AverageCalculatorPage> {
  String modeText = "";
  bool isVisible = true;
  ScrollController scrollController = ScrollController();

  TextFieldListController controller = TextFieldListController();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  Widget? textFields;
  int index = 0;

  @override
  void initState() {
    super.initState();
    textFields = TextFieldList(
      controller: controller,
      formKey: formKey,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    modeText = calculateMode(controller.textFieldValues
            .map((e) => num.tryParse(e) ?? 0)
            .toList())
        .entries
        .map((e) => "${e.key}: ${e.value}")
        .join(", ")
        .toString();

    textFields = TextFieldList(
      controller: controller,
      formKey: formKey,
      onChange: (_) {
        setState(() {});
        // formKey.currentState?.validate();
      },
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text("Average Calculator"),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    controller.addNewField();
                  });
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          buildResults(),
                          SingleChildScrollView(
                              child: Column(
                            children: [
                              textFields!,
                            ],
                          )),
                        ],
                      ))),
            ],
          ),
        ));
  }

  Widget buildResults() {
    return Card(
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width,
          child: Padding(
              padding: const EdgeInsets.only(
                  top: 15, left: 15, right: 15, bottom: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text("Mean"),
                      trailing: (formKey.currentState?.isValid ?? false)
                          ? Text(calculateMean(controller.textFieldValues
                                  .map((e) => num.tryParse(e) ?? 0)
                                  .toList())
                              .toString())
                          : const Text("--"),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text("Median"),
                      trailing: (formKey.currentState?.isValid ?? false)
                          ? Text(calculateMedian(controller.textFieldValues
                                  .map((e) => num.tryParse(e) ?? 0)
                                  .toList())
                              .toString())
                          : const Text("--"),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text("Mode"),
                      trailing: (formKey.currentState?.isValid ?? false)
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: AutoSizeText(
                                modeText,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                minFontSize: 10,
                                maxFontSize: 20,
                                textAlign: TextAlign.end,
                              ))
                          : const Text("--"),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text("Standard Deviation"),
                      trailing: (formKey.currentState?.isValid ?? false)
                          ? Text(calculateStandardDeviation(controller
                                  .textFieldValues
                                  .map((e) => num.tryParse(e) ?? 0)
                                  .toList())
                              .toString())
                          : const Text("--"),
                    ),
                  )
                ],
              ))),
    );
  }
}
