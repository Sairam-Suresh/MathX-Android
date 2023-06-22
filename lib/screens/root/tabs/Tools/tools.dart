import 'package:flutter/material.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/HCF_LCM_calculator.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/average_calculator.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/binary_calculator.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/calculator/calculator.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/grapher.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/pythagoras_theorem_calculator.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/quadratic_calculator.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/randomiser.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/set_calculator.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/shapes_calculator.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/trigonometry_calculator.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/unit_converter.dart';

class ToolsPage extends StatefulWidget {
  const ToolsPage(
      {Key? key, required this.hideTopAndBottom, this.deepLinkParsed})
      : super(key: key);

  final void Function(bool hide) hideTopAndBottom;
  final List<String>? deepLinkParsed;

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  bool hideTopAndBottom = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: !hideTopAndBottom
            ? AppBar(
                title: const Text("Tools"),
                actions: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          hideTopAndBottom = !hideTopAndBottom;
                          widget.hideTopAndBottom(hideTopAndBottom);
                        });
                      },
                      icon: Icon(hideTopAndBottom
                          ? Icons.zoom_in_map
                          : Icons.zoom_out_map)),
                  PopupMenuButton<String>(onSelected: (val) {
                    if (val == "Average Calculator") {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const AverageCalculatorPage();
                      }));
                    } else if (val == "HCF & LCM Calculator") {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const HCFLCMPage();
                      }));
                    } else if (val == "Pythagoras Theorem Calculator") {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const PythagorasTheoremCalculatorPage();
                      }));
                    } else if (val == "Quadratic Calculator") {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const QuadraticCalculatorPage();
                      }));
                    } else if (val == "Set Calculator") {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SetCalculatorPage();
                      }));
                    } else if (val == "Shapes Calculator") {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ShapesCalculatorPage();
                      }));
                    } else if (val == "Trigonometry Calculator") {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return TrigonometryCalculatorPage();
                      }));
                    } else if (val == "Binary Calculator") {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const BinaryConverterPage();
                      }));
                    } else if (val == "Grapher (Desmos)") {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const GrapherPage();
                      }));
                    } else if (val == "Randomise") {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const RandomiserPage();
                      }));
                    } else if (val == "Unit Converter") {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const UnitConverterPage();
                      }));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Container();
                      }));
                    }
                  }, itemBuilder: (context) {
                    return <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: "Average Calculator",
                        child: Text('Average Calculator'),
                      ),
                      const PopupMenuItem<String>(
                        value: "Binary Calculator",
                        child: Text('Binary Calculator'),
                      ),
                      const PopupMenuItem<String>(
                        value: "HCF & LCM Calculator",
                        child: Text('HCF & LCM Calculator'),
                      ),
                      const PopupMenuItem<String>(
                        value: "Pythagoras Theorem Calculator",
                        child: Text('Pythagoras Theorem Calculator'),
                      ),
                      const PopupMenuItem<String>(
                        value: "Quadratic Calculator",
                        child: Text('Quadratic Calculator'),
                      ),
                      const PopupMenuItem<String>(
                        value: "Set Calculator",
                        child: Text('Set Calculator'),
                      ),
                      const PopupMenuItem<String>(
                        value: "Shapes Calculator",
                        child: Text('Shapes Calculator'),
                      ),
                      const PopupMenuItem<String>(
                        value: "Trigonometry Calculator",
                        child: Text('Trigonometry Calculator'),
                      ),
                      const PopupMenuItem<String>(
                        value: "Grapher (Desmos)",
                        child: Text('Grapher (Desmos)'),
                      ),
                      const PopupMenuItem<String>(
                        value: "Randomise",
                        child: Text('Randomise'),
                      ),
                      const PopupMenuItem<String>(
                        value: "Unit Converter",
                        child: Text('Unit Converter'),
                      )
                    ];
                  })
                ],
              )
            : null,
        body: SafeArea(
          child: CalculatorPage(
              deepLinkParsed: widget.deepLinkParsed,
              hidingTopAndBottom: hideTopAndBottom,
              hideTopAndBottom: (hide) {
                setState(() {
                  hideTopAndBottom = hide;
                });
                widget.hideTopAndBottom(hide);
              }),
        ));
  }
}
