import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mathx_android/logic/tools/hcflcm_logic.dart';
import 'package:mathx_android/widgets/dynamictextfieldlist.dart';

class HCFLCMPage extends StatefulWidget {
  const HCFLCMPage({Key? key}) : super(key: key);

  @override
  State<HCFLCMPage> createState() => _HCFLCMPageState();
}

class _HCFLCMPageState extends State<HCFLCMPage> {
  bool isVisible = true;
  ScrollController scrollController = ScrollController();

  int index = 0; // 0 for HCF, 1 for LCM

  int numberOfFields = 2;
  List<String?> values = ["", ""];
  bool isFormValid = false;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Need to make HCF have an option to have only prime numbers

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("HCF & LCM Calculator"),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      numberOfFields += 1;
                    });
                  },
                  icon: const Icon(Icons.add))
            ],
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
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                  children: [
                    buildResults(),
                    DynamicTextFieldList(
                      count: numberOfFields,
                      onChange: (newValues, valid, count) {
                        setState(() {
                          isFormValid = valid;
                          values = newValues;
                          numberOfFields = count;
                        });
                      },
                    )
                  ],
                ))),
              ],
            ),
          )),
    );
  }

  Widget buildResults() {
    return Card(
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
              values.length >= 2 && (isFormValid)
                  ? index == 0
                      ? (calculateHCFForMultiple(values
                                  .map((e) =>
                                      int.tryParse((e ?? 0).toString()) ?? 0)
                                  .toList()) ??
                              "ERROR")
                          .toString()
                      : (calculateLCMForMultiple(values
                                  .map((e) =>
                                      int.tryParse((e ?? 0).toString()) ?? 0)
                                  .toList()) ??
                              "ERROR")
                          .toString()
                  : "--",
              style: const TextStyle(fontSize: 30),
            ),
            values.length < 2
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
                : !isFormValid
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
    );
  }
}
