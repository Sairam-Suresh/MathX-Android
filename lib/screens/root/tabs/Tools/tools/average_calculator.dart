import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

    return NotificationListener(
      onNotification: (notification) {
        if (notification is UserScrollNotification) {
          if (notification.direction == ScrollDirection.reverse && isVisible) {
            setState(() {
              isVisible = false;
            });
          } else if (notification.direction == ScrollDirection.forward &&
              !isVisible) {
            setState(() {
              isVisible = false;
            });
          }
        } else if (notification is ScrollEndNotification) {
          setState(() {
            isVisible = true;
          });
        }
        return false;
      },
      child: Scaffold(
          appBar: AppBar(title: const Text("Average Calculator")),
          floatingActionButton: buildFAB(),
          body: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          buildResults(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: textFields!,
                          ),
                        ],
                      ))),
            ],
          )),
    );
  }

  AnimatedOpacity buildFAB() {
    return AnimatedOpacity(
      opacity: isVisible || controller.textFieldValues.isEmpty ? 1 : 0,
      duration: const Duration(milliseconds: 300),
      child: isVisible || controller.textFieldValues.isEmpty
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  controller.addNewField();
                });
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget buildResults() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Card(
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
                        title: Text("Mean"),
                        trailing: (formKey.currentState?.isValid ?? false)
                            ? Text(calculateMean(controller.textFieldValues
                                    .map((e) => num.tryParse(e) ?? 0)
                                    .toList())
                                .toString())
                            : Text("--"),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text("Median"),
                        trailing: (formKey.currentState?.isValid ?? false)
                            ? Text(calculateMedian(controller.textFieldValues
                                    .map((e) => num.tryParse(e) ?? 0)
                                    .toList())
                                .toString())
                            : Text("--"),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text("Mode"),
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
                            : Text("--"),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text("Standard Deviation"),
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
      ),
    );
  }
}
