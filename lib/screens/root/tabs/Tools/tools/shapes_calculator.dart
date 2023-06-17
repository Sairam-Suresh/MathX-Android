import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:mathx_android/widgets/fixedtextfieldlist.dart';
import 'package:mathx_android/widgets/nestedtabbar.dart';

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
}

class buildRectangle extends StatefulWidget {
  const buildRectangle({super.key});

  @override
  State<buildRectangle> createState() => _buildRectangleState();
}

class _buildRectangleState extends State<buildRectangle> {
  List<String?> values = ["", ""];
  bool isFormValid = false;

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
                      "A = ${values[0] == "" || values[0] == null ? "l" : values[0]} * ${values.last == "" || values.last == null ? "b" : values.last}${(values.length == 2 && isFormValid) ? "= ${values.map((e) => int.parse(e!)).reduce((value, element) => value * element)}" : ""}",
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ))),
        ),
        FixedTextFieldList(
          entries: const ["Length (l)", "Breadth (b)"],
          onChange: (newValue, isValid) {
            setState(() {
              values = newValue;
              isFormValid = isValid;
            });
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
  List<String?> values = ["", ""];
  bool isFormValid = false;

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
                      "${values[0] == "" ? "l" : values[0]} * ${values.last == "" || values.length == 1 ? "b" : values.last}${(values.length == 2 && isFormValid) ? "= ${values.map((e) => int.parse(e!)).reduce((value, element) => value * element) * 0.10}" : ""}",
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ))),
        ),
        FixedTextFieldList(
          entries: const ["Length (l)", "Breadth (b)"],
          onChange: (newValues, isValid) {
            setState(() {
              values = newValues.map((e) => e ?? "").toList();
              isFormValid = isValid;
            });
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
  List<String?> values = [""];
  bool isFormValid = false;

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
                      "${values[0] == "" ? "r^2" : "${values[0]}^2"}"
                      "${values[0] != "" ? int.tryParse(values[0]!) != null ? "= ${pow(int.tryParse(values[0]!)!, 2) * pi}" : "= ERROR" : ""}",
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ))),
        ),
        FixedTextFieldList(
          entries: const ["Radius (r)"],
          onChange: (newValues, isValid) {
            setState(() {
              values = newValues.map((e) => e ?? "").toList();
              isFormValid = isValid;
            });
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
  List<String?> values = ["", "", ""];
  bool isFormValid = false;

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
                      " {${values[0] == "" ? "a" : values[0]}+${(values.elementAtOrNull(1) ?? "") == "" ? "b" : values[1]}}"
                      "{2}*"
                      "${(values.elementAtOrNull(2) ?? "") == "" ? "h" : values[2]}"
                      "${(values.length == 3 && isFormValid) ? "= ${(int.parse(values[0]!) + int.parse(values[1]!)) / 2 * int.parse(values[2]!)}" : ""}",
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ))),
        ),
        FixedTextFieldList(
          entries: const ["Base (a)", "Base (b)", "Height (h)"],
          onChange: (newValues, isValid) {
            setState(() {
              values = newValues.map((e) => e ?? "").toList();
              isFormValid = isValid;
            });
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
  List<String?> values = ["", ""];
  bool isFormValid = false;

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
                      "A = ${values[0] == "" ? "l" : values[0]} * ${values.last == "" || values.length == 1 ? "b" : values.last}${(values.length == 2 && isFormValid) ? "= ${values.map((e) => int.parse(e!)).reduce((value, element) => value * element)}" : ""}",
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ))),
        ),
        FixedTextFieldList(
          entries: const ["Length (l)", "Breadth (b)"],
          onChange: (newValues, isValid) {
            setState(() {
              values = newValues.map((e) => e ?? "").toList();
              isFormValid = isValid;
            });
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
  List<String?> values = ["", "", ""];
  bool isFormValid = false;

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
                      "${values[0] == "" ? "l" : values[0]}"
                      " * "
                      "${values.elementAtOrNull(1) == "" || values.length < 2 ? "b" : values.elementAt(1)} "
                      " * "
                      "${values.elementAtOrNull(2) == "" || values.length != 3 ? "h" : values.elementAt(2)} "
                      "${(values.length == 3 && isFormValid) ? "= ${values.map((e) => int.parse(e!)).reduce((value, element) => value * element)}" : ""}",
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ))),
        ),
        FixedTextFieldList(
          entries: const ["Length (l)", "Breadth (b)", "Height (h)"],
          onChange: (newValues, isValid) {
            setState(() {
              values = newValues.map((e) => e ?? "").toList();
              isFormValid = isValid;
            });
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
  List<String?> values = ["", "", ""];
  bool isFormValid = false;

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
                      "${values[0] == "" ? "l" : values[0]}"
                      "*"
                      "${values.elementAtOrNull(1) == "" || values.length < 2 ? "b" : values.elementAt(1)} "
                      "*"
                      "${values.elementAtOrNull(2) == "" || values.length != 3 ? "h" : values.elementAt(2)} "
                      "}{3}"
                      "${(values.length == 3 && isFormValid) ? "= ${values.map((e) => int.parse(e!)).reduce((value, element) => value * element) / 3}" : ""}",
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ))),
        ),
        FixedTextFieldList(
          entries: const ["Base Length (l)", "Base Breadth (b)", "Height (h)"],
          onChange: (newValues, isValid) {
            setState(() {
              values = newValues.map((e) => e ?? "").toList();
              isFormValid = isValid;
            });
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
  List<String?> values = [""];
  bool isFormValid = false;

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
                      "${values[0] == "" ? "r^3" : "${values[0]}^2"}"
                      "${values[0] != "" ? int.tryParse(values[0]!) != null ? "= ${pow(int.tryParse(values[0]!)!, 3) * pi * 4 / 3}" : "= ERROR" : ""}",
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ))),
        ),
        FixedTextFieldList(
          entries: const ["Radius (r)"],
          onChange: (newValues, isValid) {
            setState(() {
              values = newValues.map((e) => e ?? "").toList();
              isFormValid = isValid;
            });
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
  List<String?> values = ["", ""];
  bool isFormValid = false;

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
                      "${values[0] == "" ? "r^2" : "${values[0]}^2"}"
                      "*"
                      "${values.elementAtOrNull(1) == "" || values.length < 2 ? "h" : values.elementAt(1)}"
                      "${values[0] != "" && values.elementAtOrNull(1) != "" ? int.tryParse(values[0]!) != null ? "= ${pow(int.tryParse(values[0]!)!, 2) * pi}" : "= ERROR" : ""}",
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ))),
        ),
        FixedTextFieldList(
          entries: const ["Radius (r)", "Height (h)"],
          onChange: (newValues, isValid) {
            setState(() {
              values = newValues.map((e) => e ?? "").toList();
              isFormValid = isValid;
            });
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
  List<String?> values = ["", ""];
  bool isFormValid = false;

  @override
  Widget build(BuildContext context) {
    print(
      r"V = \pi * "
      "${values[0] == "" ? "r^2" : "${values[0]}^2"}"
      "* "
      r"\frac"
      "{${values.elementAtOrNull(1) == "" || values.length < 2 ? "h" : values.elementAt(1)}}{3}"
      "${values[0] != "" && values.elementAtOrNull(1) != "" ? int.tryParse(values[0]!) != null ? "= ${pow(int.tryParse(values[0]!)!, 2) * pi}" : "= ERROR" : ""}",
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
                      "${values[0] == "" ? "r^2" : "${values[0]}^2"}"
                      "* "
                      r"\frac"
                      "{${values.elementAtOrNull(1) == "" || values.length < 2 ? "h" : values.elementAt(1)}}{3}"
                      "${values[0] != "" && values.elementAtOrNull(1) != "" && values.elementAtOrNull(1) != null ? int.tryParse(values[0]!) != null ? "= ${pow(int.tryParse(values[0]!)!, 2) * pi * (int.tryParse(values[1]!)! / 3)}" : "= ERROR" : ""}",
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ))),
        ),
        FixedTextFieldList(
          entries: const ["Radius (r)", "Height (h)"],
          onChange: (newValues, isValid) {
            setState(() {
              values = newValues.map((e) => e ?? "").toList();
              isFormValid = isValid;
            });
          },
        )
      ]),
    );
  }
}
