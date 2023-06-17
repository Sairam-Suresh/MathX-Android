import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mathx_android/logic/tools/AverageLogic.dart';
import 'package:mathx_android/widgets/dynamictextfieldlist.dart';

class AverageCalculatorPage extends StatefulWidget {
  const AverageCalculatorPage({Key? key}) : super(key: key);

  @override
  State<AverageCalculatorPage> createState() => _AverageCalculatorPageState();
}

class _AverageCalculatorPageState extends State<AverageCalculatorPage> {
  String modeText = "";
  bool isVisible = true;
  ScrollController scrollController = ScrollController();
  int index = 0;

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
    modeText = isFormValid
        ? calculateMode(values.map((e) => num.tryParse(e!) ?? 0).toList())
            .entries
            .map((e) => "${e.key}: ${e.value}")
            .join(", ")
            .toString()
        : "";

    return Scaffold(
        appBar: AppBar(
          title: const Text("Average Calculator"),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    numberOfFields += 1;
                  });
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
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
                              DynamicTextFieldList(
                                count: numberOfFields,
                                onChange: (newValues, isValid, count) {
                                  setState(() {
                                    values = newValues;
                                    isFormValid = isValid;
                                    numberOfFields = count;
                                  });
                                },
                              )
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
                      title: Text(
                        "Mean",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      trailing: isFormValid
                          ? Text(
                              calculateMean(values
                                      .map((e) => num.tryParse(e!) ?? 0)
                                      .toList())
                                  .toString(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            )
                          : Text(
                              "--",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        "Median",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      trailing: isFormValid
                          ? Text(
                              calculateMedian(values
                                      .map((e) => num.tryParse(e!) ?? 0)
                                      .toList())
                                  .toString(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            )
                          : Text(
                              "--",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        "Mode",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      trailing: isFormValid
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: AutoSizeText(
                                modeText,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                minFontSize: 10,
                                maxFontSize: 20,
                                textAlign: TextAlign.end,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ))
                          : Text(
                              "--",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        "Standard Deviation",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      trailing: isFormValid
                          ? Text(
                              calculateStandardDeviation(values
                                      .map((e) => num.tryParse(e!) ?? 0)
                                      .toList())
                                  .toString(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            )
                          : Text(
                              "--",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                    ),
                  )
                ],
              ))),
    );
  }
}
