import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/average_calculator.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/binary_calculator.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/calculator/calculator.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/grapher.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/hcf_lcm_calculator.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/pythagoras_theorem_calculator.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/quadratic_calculator.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/randomiser.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/set_calculator.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/shapes_calculator.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/trigonometry_calculator.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/unit_converter.dart';

// var firstCat = [
//   {"name": "Average Calculator", "value": const AverageCalculatorPage()},
//   {"name": "Binary Calculator", "value": const BinaryConverterPage()},
//   {"name": "HCF & LCM Calculator", "value": const HCFLCMPage()},
// ];

// var secondCat = [
//   {
//     "name": "Pythagoras Theorem Calculator",
//     "value": const PythagorasTheoremCalculatorPage()
//   },
//   {"name": "Quadratic Calculator", "value": const QuadraticCalculatorPage()},
//   {"name": "Set Calculator", "value": const SetCalculatorPage()},
// ];

// var thirdCat = [
//   {"name": "Shapes Calculator", "value": const ShapesCalculatorPage()},
//   {
//     "name": "Trigonometry Calculator",
//     "value": const TrigonometryCalculatorPage()
//   },
//   {"name": "Grapher (Desmos)", "value": const GrapherPage()},
// ];
// var fourthCat = [
//   {"name": "Randomise", "value": const RandomiserPage()},
//   {"name": "Unit Converter", "value": const UnitConverterPage()},
// ];

enum ToolType { calculators, grapher, converters, randomiser, none }

class ToolInfo {
  String name;
  dynamic page;
  ToolType filterType;

  ToolInfo({
    required this.name,
    this.page,
    required this.filterType,
  });
}

// const allTools = [
//   {"name": "Average Calculator", "value": AverageCalculatorPage()},
//   {"name": "Binary Calculator", "value": BinaryConverterPage()},
//   {"name": "HCF & LCM Calculator", "value": HCFLCMPage()},
//   {
//     "name": "Pythagoras Theorem Calculator",
//     "value": PythagorasTheoremCalculatorPage()
//   },
//   {"name": "Quadratic Calculator", "value": QuadraticCalculatorPage()},
//   {"name": "Set Calculator", "value": SetCalculatorPage()},
//   {"name": "Shapes Calculator", "value": ShapesCalculatorPage()},
//   {"name": "Trigonometry Calculator", "value": TrigonometryCalculatorPage()},
//   {"name": "Grapher (Desmos)", "value": GrapherPage()},
//   {"name": "Randomise", "value": RandomiserPage()},
//   {"name": "Unit Converter", "value": UnitConverterPage()},
// ];

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
  ToolType filterSelection = ToolType.none;
  
  final allTools = [
    ToolInfo(
      name: "Average Calculator",
      page: const AverageCalculatorPage(),
      filterType: ToolType.calculators,
    ),
    ToolInfo(
      name: "Binary Calculator",
      page: const BinaryConverterPage(),
      filterType: ToolType.calculators,
    ),
    ToolInfo(
      name: "HCF & LCM Calculator",
      page: const HCFLCMPage(),
      filterType: ToolType.calculators,
    ),
    ToolInfo(
      name: "Pythagoras Theorem",
      page: const PythagorasTheoremCalculatorPage(),
      filterType: ToolType.calculators,
    ),
    ToolInfo(
      name: "Quadratic Calculator",
      page: const QuadraticCalculatorPage(),
      filterType: ToolType.calculators,
    ),
    ToolInfo(
      name: "Set Calculator",
      page: const SetCalculatorPage(),
      filterType: ToolType.calculators,
    ),
    ToolInfo(
      name: "Shapes Calculator",
      page: const ShapesCalculatorPage(),
      filterType: ToolType.calculators,
    ),
    ToolInfo(
      name: "Trigonometry Calculator",
      page: const TrigonometryCalculatorPage(),
      filterType: ToolType.calculators,
    ),
    ToolInfo(
      name: "Grapher (Desmos)",
      page: const GrapherPage(),
      filterType: ToolType.grapher,
    ),
    ToolInfo(
      name: "Randomiser",
      page: const RandomiserPage(),
      filterType: ToolType.randomiser,
    ),
    ToolInfo(
      name: "Unit Converter",
      page: const UnitConverterPage(),
      filterType: ToolType.converters,
    ),
    // ToolInfo(
    //   name: "Calculator",
    //   page: CalculatorPage(
    //     hidingTopAndBottom: hideTopAndBottom,
    //   ),
    //   filterType: ToolType.calculators,
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculators"),
        actions: [
          PopupMenuButton<ToolType>(
            onSelected: (ToolType result) {
              setState(() {
                filterSelection = result;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<ToolType>>[
              const PopupMenuItem<ToolType>(
                value: ToolType.none,
                child: Text('None'),
              ),
              const PopupMenuItem<ToolType>(
                value: ToolType.calculators,
                child: Text('Calculators'),
              ),
              const PopupMenuItem<ToolType>(
                value: ToolType.grapher,
                child: Text('Graphers'),
              ),
              const PopupMenuItem<ToolType>(
                value: ToolType.converters,
                child: Text('Converters'),
              ),
              const PopupMenuItem<ToolType>(
                value: ToolType.randomiser,
                child: Text('Randomiser'),
              ),
            ],
          ),

          ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GridView.count(
          crossAxisCount: 2, // Set the number of columns here
          crossAxisSpacing: 6.0,
          mainAxisSpacing: 6.0,
          children: filterSelection == ToolType.none ? allTools.map((data) => ToolCard(cardData: data)).toList() : allTools.where((tool) => tool.filterType == filterSelection).map((data) => ToolCard(cardData: data)).toList(),
        ),
      ),

      // SingleChildScrollView(
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     const Text("  First Category", style: TextStyle(fontSize: 20)),
      //     Padding(padding: EdgeInsets.all(2)),
      //     CategoryList(
      //       content: firstCat,
      //     ),
      //     Padding(padding: EdgeInsets.all(10)),
      //     const Text("  Second Category", style: TextStyle(fontSize: 20)),
      //     Padding(padding: EdgeInsets.all(2)),
      //     CategoryList(
      //       content: secondCat,
      //     ),
      //     Padding(padding: EdgeInsets.all(10)),
      //     const Text("  Third Category", style: TextStyle(fontSize: 20)),
      //     Padding(padding: EdgeInsets.all(2)),
      //     CategoryList(
      //       content: thirdCat,
      //     ),
      //     Padding(padding: EdgeInsets.all(10)),
      //     const Text("  Fourth Category", style: TextStyle(fontSize: 20)),
      //     Padding(padding: EdgeInsets.all(2)),
      //     CategoryList(
      //       content: fourthCat,
      //     ),
      //   ],
      // )),
    );
  }
}

class ToolCard extends StatelessWidget {
  final ToolInfo cardData;

  ToolCard({required this.cardData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => cardData.page),
        );
      },
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Center(
              child: Text(
                cardData.name,
                style: const TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  final dynamic content;
  // final int content;
  const CategoryList({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    // return SingleChildScrollView(
    //   scrollDirection: Axis.horizontal,
    //   child: Row(children: [CategoryItem(0), CategoryItem(0), CategoryItem(0), ]),
    // );
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color.fromARGB(255, 166, 100, 245)),
      // padding: const EdgeInsets.only(left: 10, right: 10),
      margin: const EdgeInsets.only(left: 10, right: 10),
      height: MediaQuery.of(context).size.width / 2.8,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: content
            .length, // Replace with the number of items you want to scroll
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: CategoryItem(content: content[index]),
          );
        },
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        // padding: const EdgeInsets.all(10),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final Map content;
  CategoryItem({required this.content});

  @override
  Widget build(BuildContext context) {
    double itemSize = MediaQuery.of(context).size.width / 2.8;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => content["value"],
          ),
        );
      },
      child: Container(
        width: itemSize,
        height: itemSize,
        decoration: const BoxDecoration(
            color: Color.fromARGB(100, 0, 0, 0),
            borderRadius: BorderRadius.all(Radius.circular(14))),
        child: Center(
          child: Text(
            "${content["name"]}",
            style: const TextStyle(color: Colors.white, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}





// class _ToolsPageState extends State<ToolsPage> {
//   bool hideTopAndBottom = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: SafeArea(
//           child: CalculatorPage(
//               deepLinkParsed: widget.deepLinkParsed,
//               hidingTopAndBottom: hideTopAndBottom,
//               icons: [
//                 IconButton(
//                     onPressed: () {
//                       setState(() {
//                         hideTopAndBottom = !hideTopAndBottom;
//                         if (hideTopAndBottom) {
//                           SystemChrome.setEnabledSystemUIMode(
//                               SystemUiMode.immersive,
//                               overlays: []);
//                         } else {
//                           SystemChrome.setEnabledSystemUIMode(
//                               SystemUiMode.manual,
//                               overlays:
//                                   SystemUiOverlay.values); // to re-show bars
//                         }

//                         widget.hideTopAndBottom(hideTopAndBottom);
//                       });
//                     },
//                     iconSize: 20,
//                     padding: EdgeInsets.zero,
//                     icon: Icon(
//                       hideTopAndBottom ? Icons.zoom_in_map : Icons.zoom_out_map,
//                       color: Colors.white,
//                     )),
//                 PopupMenuButton<String>(
//                     icon: const Icon(
//                       Icons.more_vert,
//                       color: Colors.white,
//                     ),
//                     iconSize: 20,
//                     padding: EdgeInsets.zero,
//                     onSelected: (val) {
//                       if (val == "Average Calculator") {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return const AverageCalculatorPage();
//                         }));
//                       } else if (val == "HCF & LCM Calculator") {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return const HCFLCMPage();
//                         }));
//                       } else if (val == "Pythagoras Theorem Calculator") {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return const PythagorasTheoremCalculatorPage();
//                         }));
//                       } else if (val == "Quadratic Calculator") {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return const QuadraticCalculatorPage();
//                         }));
//                       } else if (val == "Set Calculator") {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return const SetCalculatorPage();
//                         }));
//                       } else if (val == "Shapes Calculator") {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return const ShapesCalculatorPage();
//                         }));
//                       } else if (val == "Trigonometry Calculator") {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return const TrigonometryCalculatorPage();
//                         }));
//                       } else if (val == "Binary Calculator") {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return const BinaryConverterPage();
//                         }));
//                       } else if (val == "Grapher (Desmos)") {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return const GrapherPage();
//                         }));
//                       } else if (val == "Randomise") {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return const RandomiserPage();
//                         }));
//                       } else if (val == "Unit Converter") {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return const UnitConverterPage();
//                         }));
//                       } else {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return Container();
//                         }));
//                       }
//                     },
//                     itemBuilder: (context) {
//                       return <PopupMenuEntry<String>>[
//                         const PopupMenuItem<String>(
//                           value: "Average Calculator",
//                           child: Text('Average Calculator'),
//                         ),
//                         const PopupMenuItem<String>(
//                           value: "Binary Calculator",
//                           child: Text('Binary Calculator'),
//                         ),
//                         const PopupMenuItem<String>(
//                           value: "HCF & LCM Calculator",
//                           child: Text('HCF & LCM Calculator'),
//                         ),
//                         const PopupMenuItem<String>(
//                           value: "Pythagoras Theorem Calculator",
//                           child: Text('Pythagoras Theorem Calculator'),
//                         ),
//                         const PopupMenuItem<String>(
//                           value: "Quadratic Calculator",
//                           child: Text('Quadratic Calculator'),
//                         ),
//                         const PopupMenuItem<String>(
//                           value: "Set Calculator",
//                           child: Text('Set Calculator'),
//                         ),
//                         const PopupMenuItem<String>(
//                           value: "Shapes Calculator",
//                           child: Text('Shapes Calculator'),
//                         ),
//                         const PopupMenuItem<String>(
//                           value: "Trigonometry Calculator",
//                           child: Text('Trigonometry Calculator'),
//                         ),
//                         const PopupMenuItem<String>(
//                           value: "Grapher (Desmos)",
//                           child: Text('Grapher (Desmos)'),
//                         ),
//                         const PopupMenuItem<String>(
//                           value: "Randomise",
//                           child: Text('Randomise'),
//                         ),
//                         const PopupMenuItem<String>(
//                           value: "Unit Converter",
//                           child: Text('Unit Converter'),
//                         )
//                       ];
//                     })
//               ]),
//         ));
//   }
// }
