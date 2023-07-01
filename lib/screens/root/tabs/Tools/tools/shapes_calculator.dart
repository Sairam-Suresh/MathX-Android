import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mathx_android/widgets/equationcard.dart';
import 'package:mathx_android/widgets/nestedtabbar.dart';
import 'package:mathx_android/widgets/shapescalculatorgeometricalshapepage.dart';

// TODO: Fix and clean up all null-safety ternary operator expressions in the cards

class ShapesCalculatorPage extends StatelessWidget {
  const ShapesCalculatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              title: const Text("Shapes Calculator"),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    child: Text("2D"),
                  ),
                  Tab(
                    child: Text("3D"),
                  )
                ],
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

class buildRectangle extends StatelessWidget {
  const buildRectangle({super.key});

  @override
  Widget build(BuildContext context) {
    return GeometricalShapeTab(
        entries: const ["Length (l)", "Breadth (b)"],
        builder: (values, isFormValid) {
          return EquationCard(
              text:
                  "A = ${values[0] == "" || values[0] == null ? "l" : values[0]} * ${values.last == "" || values.last == null ? "b" : values.last} ${(values.length == 2 && isFormValid) ? "= ${values.map((e) => int.parse(e!)).reduce((value, element) => value * element)}" : ""}");
        });
  }
}

class buildTriangle extends StatelessWidget {
  const buildTriangle({super.key});

  @override
  Widget build(BuildContext context) {
    return GeometricalShapeTab(
        entries: const ["Length (l)", "Breadth (b)"],
        builder: (values, isFormValid) {
          return EquationCard(
            text: r"A = \frac 1 2 * "
                "${(values[0] ?? "") == "" ? "l" : values[0]} * ${values.last == "" || values.length == 1 ? "b" : values.last}${(values.length == 2 && isFormValid) ? "= ${values.map((e) => int.parse(e!)).reduce((value, element) => value * element) * 0.10}" : ""}",
          );
        });
  }
}

class buildCircle extends StatelessWidget {
  const buildCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return GeometricalShapeTab(
        entries: const ["Radius (r)"],
        builder: (values, isFormValid) {
          return EquationCard(
            text: r"A = \pi * "
                "${values[0] == "" ? "r^2" : "${values[0]}^2"}"
                "${values[0] != "" ? int.tryParse(values[0]!) != null ? "= ${pow(int.tryParse(values[0]!)!, 2) * pi}" : "= ERROR" : ""}",
          );
        });
  }
}

class buildTrapezium extends StatelessWidget {
  const buildTrapezium({super.key});
  @override
  Widget build(BuildContext context) {
    return GeometricalShapeTab(
        entries: const ["Base (a)", "Base (b)", "Height (h)"],
        builder: (values, isFormValid) {
          return EquationCard(
            text: r"A = \frac"
                " {${(values[0] ?? "") == "" ? "a" : values[0]}+${(values.elementAtOrNull(1) ?? "") == "" ? "b" : values[1]}}"
                "{2}*"
                "${(values.elementAtOrNull(2) ?? "") == "" ? "h" : values[2]}"
                "${(values.length == 3 && isFormValid) ? "= ${(int.parse(values[0]!) + int.parse(values[1]!)) / 2 * int.parse(values[2]!)}" : ""}",
          );
        });
  }
}

class buildParallelogram extends StatelessWidget {
  const buildParallelogram({super.key});

  @override
  Widget build(BuildContext context) {
    return GeometricalShapeTab(
        entries: const ["Length (l)", "Height (h)"],
        builder: (values, isFormValid) {
          values = values
              .map((e) => e ?? "")
              .toList(); // To aid conversion from null to ""

          final l = (values[0]) == ""
              ? "l"
              : values[0]; // String values to be shown to user
          final h = (values[1]) == ""
              ? "h"
              : values[1]; // String values to be shown to user

          final intL = int.tryParse(
              l!); // Integer values from user converted here (null if we get "")
          final intW = int.tryParse(
              h!); // Integer values from user converted here (null if we get "")

          final area = isFormValid ? intL! * intW! : null;

          return EquationCard(
            text: "A = $l * $h${area != null ? "= $area" : ""}",
          );
        });
  }
}

class buildCuboid extends StatelessWidget {
  const buildCuboid({super.key});

  @override
  Widget build(BuildContext context) {
    return GeometricalShapeTab(
        entries: const ["Length (l)", "Width (w)", "Height (h)"],
        builder: (values, isFormValid) {
          values = values
              .map((e) => e ?? "")
              .toList(); // To aid conversion from null to ""

          final l = (values[0]) == ""
              ? "l"
              : values[0]; // String values to be shown to user
          final w = (values[1]) == ""
              ? "w"
              : values[1]; // String values to be shown to user
          final h = (values[2]) == ""
              ? "h"
              : values[2]; // String values to be shown to user

          final intL = int.tryParse(values[
              0]!); // Integer values from user converted here (null if we get "")
          final intW = int.tryParse(values[
              1]!); // Integer values from user converted here (null if we get "")
          final intH = int.tryParse(values[
              2]!); // Integer values from user converted here (null if we get "")

          final volume = isFormValid ? intL! * intW! * intH! : null;
          final surfaceArea = isFormValid
              ? 2 * intL! * intW! + 2 * intW * intH! + 2 * intL * intH
              : null;

          return Column(
            children: [
              EquationCard(
                  labelText: "Volume",
                  text: "V = "
                      "$l"
                      " * "
                      "$w"
                      " * "
                      "$h "
                      "${(volume != null) ? " = $volume" : ""}"),
              EquationCard(
                labelText: "Surface Area",
                text: "A = "
                    "2($l)($w)"
                    " + "
                    "2($l)($h)"
                    " + "
                    "2($w)($h)"
                    "${(surfaceArea != null) ? " = $surfaceArea" : ""}",
              ),
            ],
          );
        });
  }
}

class buildPyramid extends StatelessWidget {
  const buildPyramid({super.key});

  @override
  Widget build(BuildContext context) {
    return GeometricalShapeTab(
        entries: const ["Base Length (l)", "Base Width (w)", "Height (h)"],
        builder: (values, isFormValid) {
          values = values
              .map((e) => e ?? "")
              .toList(); // To aid conversion from null to ""

          final l = (values[0]) == ""
              ? "l"
              : values[0]; // String values to be shown to user
          final w = (values[1]) == ""
              ? "w"
              : values[1]; // String values to be shown to user
          final h = (values[2]) == ""
              ? "h"
              : values[2]; // String values to be shown to user

          final intL = num.tryParse(values[
              0]!); // Integer values from user converted here (null if we get "")
          final intW = num.tryParse(values[
              1]!); // Integer values from user converted here (null if we get "")
          final intH = num.tryParse(values[
              2]!); // Integer values from user converted here (null if we get "")

          final volume = isFormValid ? (intL! * intW! * intH!) / 3 : null;

          final surfaceArea = isFormValid
              ? (intL! * intW! +
                  (intL * (sqrt(pow(intW / 2, 2) + pow(intH!, 2)))) +
                  (intW * (sqrt(pow(intL / 2, 2) + pow(intH, 2)))))
              : null;

          return Column(
            children: [
              EquationCard(
                labelText: "Volume",
                text: r"V = \frac{"
                    "$l"
                    "*"
                    "$w"
                    "*"
                    "$h"
                    "}{3}"
                    "${(volume != null) ? " = $volume" : ""}",
              ),
              EquationCard(
                labelText: "Surface Area",
                text:
                    "A = $l($w)+$l(\\sqrt{(\\frac{$w}{2})^2 + $h^2} )+ $w(\\sqrt{(\\frac{$l}{2})^2+$h^2})"
                    "${(surfaceArea != null) ? " = $surfaceArea" : ""}",
              ),
            ],
          );
        });
  }
}

class buildSphere extends StatelessWidget {
  const buildSphere({super.key});

  @override
  Widget build(BuildContext context) {
    return GeometricalShapeTab(
        entries: const ["Radius (r)"],
        builder: (values, isFormValid) {
          values = values
              .map((e) => e ?? "")
              .toList(); // To aid conversion from null to ""

          final r = (values[0]) == ""
              ? "r"
              : values[0]; // String values to be shown to user

          final intR = int.tryParse(values[
              0]!); // Integer values from user converted here (null if we get "")

          final volume =
              isFormValid ? (4 / 3) * pi * (intR! * intR * intR) : null;

          final surfaceArea = isFormValid ? (4 * pi * (intR! * intR)) : null;

          return Column(
            children: [
              EquationCard(
                labelText: "Volume",
                text: r"V = \frac{4}{3} * \pi * "
                    "$r^3"
                    "${volume != null ? "= $volume" : ""}",
              ),
              EquationCard(
                labelText: "Surface Area",
                text: r"A = 4 * \pi * "
                    "$r^2"
                    "${surfaceArea != null ? "= $surfaceArea" : ""}",
              ),
            ],
          );
        });
  }
}

class buildCylinder extends StatelessWidget {
  const buildCylinder({super.key});

  @override
  Widget build(BuildContext context) {
    return GeometricalShapeTab(
        entries: const ["Radius (r)", "Height (h)"],
        builder: (values, isFormValid) {
          values = values
              .map((e) => e ?? "")
              .toList(); // To aid conversion from null to ""

          final r = (values[0]) == ""
              ? "r"
              : values[0]; // String values to be shown to user
          final h = (values[1]) == ""
              ? "h"
              : values[1]; // String values to be shown to user

          final intR = int.tryParse(values[
              0]!); // Integer values from user converted here (null if we get "")
          final intH = int.tryParse(values[
              1]!); // Integer values from user converted here (null if we get "")

          final volume = isFormValid ? pi * (intR! * intR) * intH! : null;
          final surfaceArea = isFormValid
              ? 2 * pi * intR! * intR + 2 * pi * intR * intH!
              : null;

          return Column(
            children: [
              EquationCard(
                labelText: "Volume",
                text: r"V = \pi * "
                    "$r^2"
                    "*"
                    "$h"
                    "${volume != null ? " = $volume" : ""}",
              ),
              EquationCard(
                labelText: "Surface Area",
                text: "A = 2\\pi ($r)^2 + 2\\pi ($r)($h)"
                    "${surfaceArea != null ? " = $surfaceArea" : ""}",
              ),
            ],
          );
        });
  }
}

class buildCone extends StatelessWidget {
  const buildCone({super.key});

  @override
  Widget build(BuildContext context) {
    return GeometricalShapeTab(
        entries: const ["Radius (r)", "Height (h)"],
        builder: (values, isFormValid) {
          values = values
              .map((e) => e ?? "")
              .toList(); // To aid conversion from null to ""

          final r = (values[0]) == ""
              ? "r"
              : values[0]; // String values to be shown to user
          final h = (values[1]) == ""
              ? "h"
              : values[1]; // String values to be shown to user

          final intR = int.tryParse(values[
              0]!); // Integer values from user converted here (null if we get "")
          final intH = int.tryParse(values[
              1]!); // Integer values from user converted here (null if we get "")

          final volume = isFormValid ? pi * (intR! * intR) * (intH! / 3) : null;
          final surfaceArea = isFormValid
              ? pi * (intR!) * (intR + sqrt(intH! * intH + intR * intR))
              : null;

          return Column(
            children: [
              EquationCard(
                labelText: "Volume",
                text: r"V = \pi * "
                    "$r^2"
                    "* "
                    r"\frac"
                    "{$h}{3}"
                    "${(volume != null) ? "= $volume" : ""}",
              ),
              EquationCard(
                labelText: "Surface Area",
                text: "A = \\pi ($r)($r + \\sqrt{$h^2+$r^2})"
                    "${(surfaceArea != null) ? "= $surfaceArea" : ""}",
              ),
            ],
          );
        });
  }
}
