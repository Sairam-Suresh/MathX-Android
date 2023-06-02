import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mathx_android/logic/tools/HCFLCMLogic.dart';
import 'package:mathx_android/widgets/textfieldlist.dart';

class HCFLCMPage extends StatefulWidget {
  const HCFLCMPage({Key? key}) : super(key: key);

  @override
  State<HCFLCMPage> createState() => _HCFLCMPageState();
}

class _HCFLCMPageState extends State<HCFLCMPage> {
  bool firstRender = true;
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
  Widget build(BuildContext context) {
    // TODO: Need to make HCF have an option to have only prime numbers
    textFields = TextFieldList(
      controller: controller,
      formKey: formKey,
      onChange: (_) {
        setState(() {});
        formKey.currentState?.validate();
      },
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("HCF & LCM Calculator"),
            bottom: TabBar(
              tabs: const [
                Tab(text: "Highest Common Factor"),
                Tab(text: "Lowest Common Multiple"),
              ],
              onTap: (val) {
                setState(() {
                  index = val;
                });
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                controller.addNewField();
              });
            },
            child: const Icon(Icons.add),
          ),
          body: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: textFields!,
                  ),
                  buildResults()
                ],
              ))),
            ],
          )),
    );
  }

  Card buildResults() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              index == 0 ? "Highest Common Factor" : "Lowest Common Multiple",
              style: const TextStyle(fontSize: 25),
            ),
            AutoSizeText(
              controller.textFieldValues.length >= 2 &&
                      (formKey.currentState?.isValid ?? false)
                  ? index == 0
                      ? (calculateHCFForMultiple(controller.textFieldValues
                                  .map((e) => int.tryParse(e) ?? 0)
                                  .toList()) ??
                              "ERROR")
                          .toString()
                      : (calculateLCMForMultiple(controller.textFieldValues
                                  .map((e) => int.tryParse(e) ?? 0)
                                  .toList()) ??
                              "ERROR")
                          .toString()
                  : "--",
              style: const TextStyle(fontSize: 30),
            ),
            controller.textFieldValues.length < 2
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
                          children: const [
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
        ),
      ),
    );
  }
}
