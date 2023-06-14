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
          body: const TabBarView(children: [
            NestedTabBar(
              "2D",
              children: {
                "Rectangle": buildRectangle(),
                "Triangle": buildTriangle(),
                "Circle": buildCircle(),
                "Trapezium": buildTrapezium(),
                "Parallelogram": const buildParallelogram(),
              },
            ),
            NestedTabBar(
              "3D",
              children: {
                "Cuboid": const buildCuboid(),
                "Pyramid": const buildPyramid(),
                "Sphere": const buildSphere(),
                "Cylinder": buildCylinder(),
                "Cone": buildCone(),
              },
            )
          ]),
        ));
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
      padding: const EdgeInsets.all(10),
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
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        Card(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Math.tex(
                      r"A = \frac 1 2 * "
                      "${controller.textFieldValues[0] == "" ? "l" : controller.textFieldValues[0]} * ${controller.textFieldValues.last == "" || controller.textFieldValues.length == 1 ? "b" : controller.textFieldValues.last}${(controller.textFieldValues.length == 2 && (formKey.currentState?.isValid ?? false)) ? "= ${controller.textFieldValues.map((e) => int.parse(e)).reduce((value, element) => value * element) * 0.10}" : ""}",
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
      padding: const EdgeInsets.all(10),
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
      padding: const EdgeInsets.all(10),
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
      padding: const EdgeInsets.all(10),
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

class buildCuboid extends StatefulWidget {
  const buildCuboid({super.key});

  @override
  State<buildCuboid> createState() => _buildCuboidState();
}

class _buildCuboidState extends State<buildCuboid> {
  TextFieldListController controller = TextFieldListController();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        Card(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Math.tex(
                      "V = "
                      "${controller.textFieldValues[0] == "" ? "l" : controller.textFieldValues[0]}"
                      " * "
                      "${controller.textFieldValues.elementAtOrNull(1) == "" || controller.textFieldValues.length < 2 ? "b" : controller.textFieldValues.elementAt(1)} "
                      " * "
                      "${controller.textFieldValues.elementAtOrNull(2) == "" || controller.textFieldValues.length != 3 ? "h" : controller.textFieldValues.elementAt(2)} "
                      "${(controller.textFieldValues.length == 3 && (formKey.currentState?.isValid ?? false)) ? "= ${controller.textFieldValues.map((e) => int.parse(e)).reduce((value, element) => value * element)}" : ""}",
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ))),
        ),
        TextFieldList(
          controller: controller,
          formKey: formKey,
          limitEntries: const {
            "Length (l)": 0,
            "Breadth (b)": 0,
            "Height (h)": 0
          },
          onChange: (_) {
            setState(() {});
          },
        )
      ]),
    );
  }
}

class buildPyramid extends StatefulWidget {
  const buildPyramid({super.key});

  @override
  State<buildPyramid> createState() => _buildPyramidState();
}

class _buildPyramidState extends State<buildPyramid> {
  @override
  TextFieldListController controller = TextFieldListController();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        Card(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Math.tex(
                      r"V = \frac{"
                      "${controller.textFieldValues[0] == "" ? "l" : controller.textFieldValues[0]}"
                      "*"
                      "${controller.textFieldValues.elementAtOrNull(1) == "" || controller.textFieldValues.length < 2 ? "b" : controller.textFieldValues.elementAt(1)} "
                      "*"
                      "${controller.textFieldValues.elementAtOrNull(2) == "" || controller.textFieldValues.length != 3 ? "h" : controller.textFieldValues.elementAt(2)} "
                      "}{3}"
                      "${(controller.textFieldValues.length == 3 && (formKey.currentState?.isValid ?? false)) ? "= ${controller.textFieldValues.map((e) => int.parse(e)).reduce((value, element) => value * element) / 3}" : ""}",
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ))),
        ),
        TextFieldList(
          controller: controller,
          formKey: formKey,
          limitEntries: const {
            "Base Length (l)": 0,
            "Base Breadth (b)": 0,
            "Height (h)": 0
          },
          onChange: (_) {
            setState(() {});
          },
        )
      ]),
    );
  }
}

class buildSphere extends StatefulWidget {
  const buildSphere({super.key});

  @override
  State<buildSphere> createState() => _buildSphereState();
}

class _buildSphereState extends State<buildSphere> {
  TextFieldListController controller = TextFieldListController();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        Card(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Math.tex(
                      r"V = \frac{4}{3} * \pi * "
                      "${controller.textFieldValues[0] == "" ? "r^3" : "${controller.textFieldValues[0]}^2"}"
                      "${controller.textFieldValues[0] != "" ? int.tryParse(controller.textFieldValues[0]) != null ? "= ${pow(int.tryParse(controller.textFieldValues[0])!, 3) * pi * 4 / 3}" : "= ERROR" : ""}",
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

class buildCylinder extends StatefulWidget {
  const buildCylinder({super.key});

  @override
  State<buildCylinder> createState() => _buildCylinderState();
}

class _buildCylinderState extends State<buildCylinder> {
  TextFieldListController controller = TextFieldListController();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        Card(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Math.tex(
                      r"V = \pi * "
                      "${controller.textFieldValues[0] == "" ? "r^2" : "${controller.textFieldValues[0]}^2"}"
                      "*"
                      "${controller.textFieldValues.elementAtOrNull(1) == "" || controller.textFieldValues.length < 2 ? "h" : controller.textFieldValues.elementAt(1)}"
                      "${controller.textFieldValues[0] != "" && controller.textFieldValues.elementAtOrNull(1) != "" ? int.tryParse(controller.textFieldValues[0]) != null ? "= ${pow(int.tryParse(controller.textFieldValues[0])!, 2) * pi}" : "= ERROR" : ""}",
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ))),
        ),
        TextFieldList(
          controller: controller,
          formKey: formKey,
          limitEntries: const {"Radius (r)": 0, "Height (h)": 0},
          onChange: (_) {
            setState(() {});
          },
        )
      ]),
    );
  }
}

class buildCone extends StatefulWidget {
  const buildCone({super.key});

  @override
  State<buildCone> createState() => _buildConeState();
}

class _buildConeState extends State<buildCone> {
  TextFieldListController controller = TextFieldListController();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    print(
      r"V = \pi * "
      "${controller.textFieldValues[0] == "" ? "r^2" : "${controller.textFieldValues[0]}^2"}"
      "* "
      r"\frac"
      "{${controller.textFieldValues.elementAtOrNull(1) == "" || controller.textFieldValues.length < 2 ? "h" : controller.textFieldValues.elementAt(1)}}{3}"
      "${controller.textFieldValues[0] != "" && controller.textFieldValues.elementAtOrNull(1) != "" ? int.tryParse(controller.textFieldValues[0]) != null ? "= ${pow(int.tryParse(controller.textFieldValues[0])!, 2) * pi}" : "= ERROR" : ""}",
    );

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        Card(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Math.tex(
                      r"V = \pi * "
                      "${controller.textFieldValues[0] == "" ? "r^2" : "${controller.textFieldValues[0]}^2"}"
                      "* "
                      r"\frac"
                      "{${controller.textFieldValues.elementAtOrNull(1) == "" || controller.textFieldValues.length < 2 ? "h" : controller.textFieldValues.elementAt(1)}}{3}"
                      "${controller.textFieldValues[0] != "" && controller.textFieldValues.elementAtOrNull(1) != "" && controller.textFieldValues.elementAtOrNull(1) != null ? int.tryParse(controller.textFieldValues[0]) != null ? "= ${pow(int.tryParse(controller.textFieldValues[0])!, 2) * pi * (int.tryParse(controller.textFieldValues[1])! / 3)}" : "= ERROR" : ""}",
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ))),
        ),
        TextFieldList(
          controller: controller,
          formKey: formKey,
          limitEntries: const {"Radius (r)": 0, "Height (h)": 0},
          onChange: (_) {
            setState(() {});
          },
        )
      ]),
    );
  }
}
