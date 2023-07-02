import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/calculator/inline_equation_sharing_view.dart';
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
                "Rectangle": BuildRectangle(),
                "Triangle": BuildTriangle(),
                "Circle": BuildCircle(),
                "Trapezium": BuildTrapezium(),
                "Parallelogram": BuildParallelogram(),
              },
            ),
            NestedTabBar(
              "3D",
              children: {
                "Cuboid": BuildCuboid(),
                "Pyramid": BuildPyramid(),
                "Sphere": BuildSphere(),
                "Cylinder": BuildCylinder(),
                "Cone": BuildCone(),
              },
            )
          ]),
        ));
  }
}

class BuildRectangle extends StatelessWidget {
  const BuildRectangle({super.key});

  @override
  Widget build(BuildContext context) {
    return GeometricalShapeTab(
        entries: const ["Length (l)", "Breadth (w)"],
        builder: (values, isFormValid) {
          values = values
              .map((e) => e ?? "")
              .toList(); // To aid conversion from null to ""

          final l = (values[0]) == "" || values[0] == null ? "l" : values[0];
          final w = (values[1]) == "" || values[1] == null ? "w" : values[1];

          final intL = num.tryParse(l!);
          final intW = num.tryParse(w!);

          final area = isFormValid ? intL! * intW! : null;

          return EquationCard(
            text: "A = $l * $w"
                "${area != null ? "= ${area.isIntValue() ? area.toInt() : area}" : ""}",
          );
        });
  }
}

class BuildTriangle extends StatelessWidget {
  const BuildTriangle({super.key});

  @override
  Widget build(BuildContext context) {
    return GeometricalShapeTab(
        entries: const ["Length (l)", "Breadth (w)"],
        builder: (values, isFormValid) {
          values = values
              .map((e) => e ?? "")
              .toList(); // To aid conversion from null to ""

          final l = (values[0]) == "" || values[0] == null ? "l" : values[0];
          final w = (values[1]) == "" || values[1] == null ? "w" : values[1];

          final intL = num.tryParse(l!);
          final intW = num.tryParse(w!);
          final area = isFormValid ? intL! * intW! * 0.5 : null;

          return EquationCard(
            text: r"A = \frac 1 2 * "
                "$l * $w"
                "${area != null ? "= ${area.isIntValue() ? area.toInt() : area}" : ""}",
          );
        });
  }
}

class BuildCircle extends StatelessWidget {
  const BuildCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return GeometricalShapeTab(
        entries: const ["Radius (r)"],
        builder: (values, isFormValid) {
          values = values
              .map((e) => e ?? "")
              .toList(); // To aid conversion from null to ""

          final r = (values[0]) == "" || values[0] == null ? "r" : values[0];
          final intR = num.tryParse(r!);
          final area = isFormValid ? intR! * intR * pi : null;

          return EquationCard(
            text: r"A = \pi * "
                "$r^2"
                "${area != null ? "= ${area.isIntValue() ? area.toInt() : area}" : ""}",
          );
        });
  }
}

class BuildTrapezium extends StatelessWidget {
  const BuildTrapezium({super.key});
  @override
  Widget build(BuildContext context) {
    return GeometricalShapeTab(
        entries: const ["Base (a)", "Base (b)", "Height (h)"],
        builder: (values, isFormValid) {
          values = values
              .map((e) => e ?? "")
              .toList(); // To aid conversion from null to ""

          final a = (values[0]) == "" || values[0] == null ? "a" : values[0];
          final b = (values[1]) == "" || values[1] == null ? "b" : values[1];
          final h = (values[2]) == "" || values[2] == null ? "h" : values[2];

          final intA = num.tryParse(a!);
          final intB = num.tryParse(b!);
          final intH = num.tryParse(h!);

          final area = isFormValid ? ((intA! + intB!) / 2) * intH! : null;

          return EquationCard(
            text: r"A = \frac"
                "{$a+$b}"
                "{2}*"
                "$h"
                "${area != null ? "= ${area.isIntValue() ? area.toInt() : area}" : ""}",
          );
        });
  }
}

class BuildParallelogram extends StatelessWidget {
  const BuildParallelogram({super.key});

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

          final intL = num.tryParse(
              l!); // Integer values from user converted here (null if we get "")
          final intW = num.tryParse(
              h!); // Integer values from user converted here (null if we get "")

          final area = isFormValid ? intL! * intW! : null;

          return EquationCard(
            text:
                "A = $l * $h${area != null ? "= ${area.isIntValue() ? area.toInt() : area}" : ""}",
          );
        });
  }
}

class BuildCuboid extends StatelessWidget {
  const BuildCuboid({super.key});

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

          final intL = num.tryParse(values[
              0]!); // Integer values from user converted here (null if we get "")
          final intW = num.tryParse(values[
              1]!); // Integer values from user converted here (null if we get "")
          final intH = num.tryParse(values[
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
                      "${(volume != null) ? " = ${volume.isIntValue() ? volume.toInt() : volume}" : ""}"),
              EquationCard(
                labelText: "Surface Area",
                text: "A = "
                    "2($l)($w)"
                    " + "
                    "2($l)($h)"
                    " + "
                    "2($w)($h)"
                    "${(surfaceArea != null) ? " = ${surfaceArea.isIntValue() ? surfaceArea.toInt() : surfaceArea}" : ""}",
              ),
            ],
          );
        });
  }
}

class BuildPyramid extends StatelessWidget {
  const BuildPyramid({super.key});

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
                    "${(volume != null) ? " = ${volume.isIntValue() ? volume.toInt() : volume}" : ""}",
              ),
              EquationCard(
                labelText: "Surface Area",
                text:
                    "A = $l($w)+$l(\\sqrt{(\\frac{$w}{2})^2 + $h^2} )+ $w(\\sqrt{(\\frac{$l}{2})^2+$h^2})"
                    "${(surfaceArea != null) ? " = ${surfaceArea.isIntValue() ? surfaceArea.toInt() : surfaceArea}" : ""}",
              ),
            ],
          );
        });
  }
}

class BuildSphere extends StatelessWidget {
  const BuildSphere({super.key});

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

          final intR = num.tryParse(values[0]!) ??
              0; // Integer values from user converted here (null if we get "")

          final volume =
              isFormValid ? (4 / 3) * pi * (intR * intR * intR) : null;

          final surfaceArea = isFormValid ? (4 * pi * (intR * intR)) : null;

          return Column(
            children: [
              EquationCard(
                labelText: "Volume",
                text: r"V = \frac{4}{3} * \pi * "
                    "$r^3"
                    "${volume != null ? "= ${volume.isIntValue() ? volume.toInt() : volume}" : ""}",
              ),
              EquationCard(
                labelText: "Surface Area",
                text: r"A = 4 * \pi * "
                    "$r^2"
                    "${surfaceArea != null ? "= ${surfaceArea.isIntValue() ? surfaceArea.toInt() : surfaceArea}" : ""}",
              ),
            ],
          );
        });
  }
}

class BuildCylinder extends StatelessWidget {
  const BuildCylinder({super.key});

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

          final intR = num.tryParse(values[
              0]!); // Integer values from user converted here (null if we get "")
          final intH = num.tryParse(values[
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
                    "${volume != null ? " = ${volume.isIntValue() ? volume.toInt() : volume}" : ""}",
              ),
              EquationCard(
                labelText: "Surface Area",
                text: "A = 2\\pi ($r)^2 + 2\\pi ($r)($h)"
                    "${surfaceArea != null ? " = ${surfaceArea.isIntValue() ? surfaceArea.toInt() : surfaceArea}" : ""}",
              ),
            ],
          );
        });
  }
}

class BuildCone extends StatelessWidget {
  const BuildCone({super.key});

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

          final intR = num.tryParse(values[
              0]!); // Integer values from user converted here (null if we get "")
          final intH = num.tryParse(values[
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
                    "${(volume != null) ? "= ${volume.isIntValue() ? volume.toInt() : volume}" : ""}",
              ),
              EquationCard(
                labelText: "Surface Area",
                text: "A = \\pi ($r)($r + \\sqrt{$h^2+$r^2})"
                    "${(surfaceArea != null) ? "= ${surfaceArea.isIntValue() ? surfaceArea.toInt() : surfaceArea}" : ""}",
              ),
            ],
          );
        });
  }
}
