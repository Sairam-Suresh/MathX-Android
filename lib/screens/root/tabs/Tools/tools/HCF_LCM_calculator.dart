import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mathx_android/logic/tools/HCFLCMLogic.dart';
import 'package:mathx_android/widgets/textfieldlist.dart';

class HCFLCMPage extends StatefulWidget {
  const HCFLCMPage({Key? key}) : super(key: key);

  @override
  State<HCFLCMPage> createState() => _HCFLCMPageState();
}

class _HCFLCMPageState extends State<HCFLCMPage> {
  TextFieldListController controller = TextFieldListController();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  Widget? textFields;
  bool isVisible = true;
  ScrollController scrollController = ScrollController();

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
    // TODO: Need to make HCF have an option to have only prime numbers
    textFields = TextFieldList(
      controller: controller,
      formKey: formKey,
      onChange: (_) {
        setState(() {});
      },
    );

    return DefaultTabController(
      length: 2,
      child: NotificationListener(
        onNotification: (notification) {
          if (notification is UserScrollNotification) {
            if (notification.direction == ScrollDirection.reverse &&
                isVisible) {
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
            appBar: AppBar(
              title: const Text("HCF & LCM Calculator"),
              bottom: TabBar(
                tabs: const [
                  Tab(
                      child: AutoSizeText(
                    "Highest Common Factor",
                    maxLines: 1,
                  )),
                  Tab(
                      child: AutoSizeText(
                    "Lowest Common Multiple",
                    maxLines: 1,
                  )),
                ],
                onTap: (val) {
                  setState(() {
                    index = val;
                  });
                },
              ),
            ),
            floatingActionButton: buildFAB(),
            body: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
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
              ),
            )),
      ),
    );
  }

  Widget buildResults() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.warning_amber),
                              SizedBox(width: 10),
                              Expanded(
                                child: AutoSizeText(
                                  "Please ensure that there are at least 2 numbers",
                                  minFontSize: 5,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : !(formKey.currentState?.isValid ?? false)
                      ? const Center(
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
          ),
        ),
      ),
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
}
