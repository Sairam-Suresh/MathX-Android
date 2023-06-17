import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mathx_android/logic/tools/PythagorasTheoremLogic.dart';
import 'package:mathx_android/widgets/fixedtextfieldlist.dart';

class PythagorasTheoremCalculatorPage extends StatefulWidget {
  const PythagorasTheoremCalculatorPage({Key? key}) : super(key: key);

  @override
  State<PythagorasTheoremCalculatorPage> createState() =>
      _PythagorasTheoremCalculatorPageState();
}

class _PythagorasTheoremCalculatorPageState
    extends State<PythagorasTheoremCalculatorPage> {
  bool only2FieldsFilled = false;
  int _noOfFieldsFilled = 0;
  String modeText = "";
  bool isVisible = true;
  ScrollController scrollController = ScrollController();

  List<String?> values = [];
  bool isFormValid = false;

  int index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          appBar: AppBar(title: const Text("Pyth Thrm Calculator")),
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
                            FixedTextFieldList(
                              entries: const ["Side A", "Side B", "Side C"],
                              onChange: (list, valid) {
                                setState(() {
                                  isFormValid = valid;
                                  values = list;
                                });
                              },
                              validators: FormBuilderValidators.compose([
                                FormBuilderValidators.numeric(),
                              ]),
                            )
                          ],
                        ))),
              ],
            ),
          )),
    );
  }

  Widget buildResults() {
    _noOfFieldsFilled = 0;

    for (String? i in values) {
      _noOfFieldsFilled += (i == "" || i == null) ? 0 : 1;
    }

    if (_noOfFieldsFilled == 2) {
      only2FieldsFilled = true;
    } else {
      only2FieldsFilled = false;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("Side A"),
              trailing: (isFormValid) && only2FieldsFilled
                  ? Text(
                      values.first != "" && values.first != null
                          ? values.first!
                          : calculateSide(
                                  num.parse(values[2]!), num.parse(values[1]!))
                              .toString(),
                      style: const TextStyle(fontSize: 20),
                    )
                  : const Text("--"),
            ),
            ListTile(
              title: const Text("Side B"),
              trailing: isFormValid && only2FieldsFilled
                  ? Text(
                      values[1] != "" && values[1] != null
                          ? values[1]!
                          : calculateSide(
                                  num.parse(values[2]!), num.parse(values[0]!))
                              .toString(),
                      style: const TextStyle(fontSize: 20),
                    )
                  : const Text("--"),
            ),
            ListTile(
              title: const Text("Side C (Hypotenuse)"),
              trailing: isFormValid && only2FieldsFilled
                  ? Text(
                      values.last != "" && values.last != null
                          ? values.last!
                          : calculateHypotenuse(
                                  num.parse(values[0]!), num.parse(values[1]!))
                              .toString(),
                      style: const TextStyle(fontSize: 20),
                    )
                  : const Text("--"),
            ),
            _noOfFieldsFilled > 2
                ? const Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.warning_amber),
                        SizedBox(width: 10),
                        Text("Please only enter 2 values"),
                      ],
                    ),
                  )
                : _noOfFieldsFilled < 2
                    ? const Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.warning_amber),
                            SizedBox(width: 10),
                            Text("Please enter at least 2 values"),
                          ],
                        ),
                      )
                    : Container()
          ],
        ),
      ),
    );
  }
}
