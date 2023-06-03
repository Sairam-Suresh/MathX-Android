import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:mathx_android/widgets/nestedtabbar.dart';
import 'package:mathx_android/widgets/textfieldlist.dart';

class ShapesCalculatorPage extends StatefulWidget {
  ShapesCalculatorPage({Key? key}) : super(key: key);

  @override
  State<ShapesCalculatorPage> createState() => _ShapesCalculatorPageState();
}

class _ShapesCalculatorPageState extends State<ShapesCalculatorPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              title: const Text("Shapes Calculator"),
              bottom: TabBar(
                tabs: const [
                  Tab(
                    child: Text("2D"),
                  ),
                  Tab(
                    child: Text("3D"),
                  )
                ],
                onTap: (index) {
                  setState(() {});
                },
              )),
          body: TabBarView(children: [
            NestedTabBar(
              "2D",
              children: {
                "Rectangle": const buildRectangle(),
                "Triangle": const buildTriangle(),
                "Circle": const buildCircle(),
                "Trapezium": const buildTrapezium(),
                "Parallelogram": buildParallelogram(),
              },
            ),
            NestedTabBar(
              "3D",
              children: {
                "Cuboid": buildCuboid(),
                "Pyramid": buildPyramid(),
                "Sphere": buildSphere(),
                "Cylinder": buildCylinder(),
                "Cone": buildCone(),
              },
            )
          ]),
        ));
  }

  Widget buildCuboid() {
    return const Text("Cuboid");
  }

  Widget buildPyramid() {
    return const Text("Pyramid");
  }

  Widget buildSphere() {
    return const Text("Sphere");
  }

  Widget buildCylinder() {
    return const Text("Cylinder");
  }

  Widget buildCone() {
    return const Text("Cone");
  }
}

class buildRectangle extends StatefulWidget {
  const buildRectangle({super.key});

  @override
  State<buildRectangle> createState() => _buildRectangleState();
}

class _buildRectangleState extends State<buildRectangle> {
  TextFieldListController controller = TextFieldListController();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(children: [
        Card(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Math.tex(
                      "A = ${controller.textFieldValues[0] == "" ? "l" : controller.textFieldValues[0]} * ${controller.textFieldValues.last == "" || controller.textFieldValues.length == 1 ? "b" : controller.textFieldValues.last}${(controller.textFieldValues.length == 2 && (formKey.currentState?.isValid ?? false)) ? "= ${controller.textFieldValues.map((e) => int.parse(e)).reduce((value, element) => value * element)}" : ""}",
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ))),
        ),
        TextFieldList(
          controller: controller,
          formKey: formKey,
          limitEntries: const {"Length (l)": 0, "Breadth (b)": 0},
          onChange: (_) {
            setState(() {});
          },
        )
      ]),
    );
  }
}

class buildTriangle extends StatefulWidget {
  const buildTriangle({super.key});

  @override
  State<buildTriangle> createState() => _buildTriangleState();
}

class _buildTriangleState extends State<buildTriangle> {
  TextFieldListController controller = TextFieldListController();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(children: [
        Card(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Math.tex(
                      r"A = \frac 1 2 * "
                      "${controller.textFieldValues[0] == "" ? "l" : controller.textFieldValues[0]} * ${controller.textFieldValues.last == "" || controller.textFieldValues.length == 1 ? "b" : controller.textFieldValues.last}${(controller.textFieldValues.length == 2 && (formKey.currentState?.isValid ?? false)) ? "= ${controller.textFieldValues.map((e) => int.parse(e)).reduce((value, element) => value * element) * 0.5}" : ""}",
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ))),
        ),
        TextFieldList(
          controller: controller,
          formKey: formKey,
          limitEntries: const {"Length (l)": 0, "Breadth (b)": 0},
          onChange: (_) {
            setState(() {});
          },
        )
      ]),
    );
  }
}

class buildCircle extends StatefulWidget {
  const buildCircle({super.key});

  @override
  State<buildCircle> createState() => _buildCircleState();
}

class _buildCircleState extends State<buildCircle> {
  TextFieldListController controller = TextFieldListController();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(children: [
        Card(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Math.tex(
                      r"A = \pi * "
                      "${controller.textFieldValues[0] == "" ? "r^2" : "${controller.textFieldValues[0]}^2"}"
                      "${controller.textFieldValues[0] != "" ? int.tryParse(controller.textFieldValues[0]) != null ? "= ${pow(int.tryParse(controller.textFieldValues[0])!, 2) * pi}" : "= ERROR" : ""}",
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ))),
        ),
        TextFieldList(
          controller: controller,
          formKey: formKey,
          limitEntries: const {"Radius (r)": 0},
          onChange: (_) {
            setState(() {});
          },
        )
      ]),
    );
  }
}

class buildTrapezium extends StatefulWidget {
  const buildTrapezium({super.key});

  @override
  State<buildTrapezium> createState() => _buildTrapeziumState();
}

class _buildTrapeziumState extends State<buildTrapezium> {
  TextFieldListController controller = TextFieldListController();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(children: [
        Card(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Math.tex(
                      r"A = \frac"
                      " {${controller.textFieldValues[0] == "" ? "a" : controller.textFieldValues[0]}+${(controller.textFieldValues.elementAtOrNull(1) ?? "") == "" ? "b" : controller.textFieldValues[1]}}"
                      "{2}*"
                      "${(controller.textFieldValues.elementAtOrNull(2) ?? "") == "" ? "h" : controller.textFieldValues[2]}"
                      "${(controller.textFieldValues.length == 3 && (formKey.currentState?.isValid ?? false)) ? "= ${(int.parse(controller.textFieldValues[0]) + int.parse(controller.textFieldValues[1])) / 2 * int.parse(controller.textFieldValues[2])}" : ""}",
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ))),
        ),
        TextFieldList(
          controller: controller,
          formKey: formKey,
          limitEntries: const {"Base (a)": 0, "Base (b)": 0, "Height (h)": 0},
          onChange: (_) {
            setState(() {});
          },
        )
      ]),
    );
  }
}

class buildParallelogram extends StatefulWidget {
  const buildParallelogram({super.key});

  @override
  State<buildParallelogram> createState() => _buildParallelogramState();
}

class _buildParallelogramState extends State<buildParallelogram> {
  TextFieldListController controller = TextFieldListController();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(children: [
        Card(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Math.tex(
                      "A = ${controller.textFieldValues[0] == "" ? "l" : controller.textFieldValues[0]} * ${controller.textFieldValues.last == "" || controller.textFieldValues.length == 1 ? "b" : controller.textFieldValues.last}${(controller.textFieldValues.length == 2 && (formKey.currentState?.isValid ?? false)) ? "= ${controller.textFieldValues.map((e) => int.parse(e)).reduce((value, element) => value * element)}" : ""}",
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ))),
        ),
        TextFieldList(
          controller: controller,
          formKey: formKey,
          limitEntries: const {"Length (l)": 0, "Breadth (b)": 0},
          onChange: (_) {
            setState(() {});
          },
        )
      ]),
    );
  }
}
