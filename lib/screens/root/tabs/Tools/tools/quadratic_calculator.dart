import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mathx_android/logic/tools/QuadraticSolverLogic.dart';
import 'package:mathx_android/widgets/textfieldlist.dart';

class QuadraticCalculatorPage extends StatefulWidget {
  const QuadraticCalculatorPage({Key? key}) : super(key: key);

  @override
  State<QuadraticCalculatorPage> createState() =>
      _QuadraticCalculatorPageState();
}

class _QuadraticCalculatorPageState extends State<QuadraticCalculatorPage> {
  QuadraticEquation equation = QuadraticEquation(0, 0, 0);
  bool isVisible = true;
  ScrollController scrollController = ScrollController();

  TextFieldListController controller = TextFieldListController();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  Widget? textFields;
  int index = 0;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    textFields = TextFieldList(
      controller: controller,
      formKey: formKey,
      onChange: (_) {
        setState(() {});
      },
      nameBuilder: (length, index) {
        if (index == 0) {
          return "Constant value";
        } else if (index == 1) {
          return "Coefficient of x";
        } else {
          return "Coefficient of x^$index";
        }
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
          appBar: AppBar(title: const Text("Polynomial Solver")),
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

  Widget buildResults() {
    return Card();
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
