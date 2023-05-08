import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mathx_android/constants.dart';
import 'package:styled_widget/styled_widget.dart';

class ToolCard extends StatelessWidget {
  ToolCard(
      {Key? key,
      required this.name,
      required this.child,
      required this.category})
      : super(key: key);

  late String name;
  late Widget child;
  late ToolCategory category;

  IconData? categoryIcon;
  String? categoryName;

  @override
  Widget build(BuildContext context) {
    switch (category) {
      case ToolCategory.Calculators:
        categoryIcon = Icons.calculate;
        categoryName = "Calculators";
        break;
      case ToolCategory.Graphers:
        categoryIcon = Icons.graphic_eq;
        categoryName = "Graphers";
        break;
      case ToolCategory.Randomise:
        categoryIcon = Icons.shuffle;
        categoryName = "Randomise";
        break;
      case ToolCategory.Unit_Converter:
        categoryIcon = Icons.refresh;
        categoryName = "Unit Converter";
        break;
    }
    ;

    return Padding(
        padding: EdgeInsets.all(PADDING_BETWEEN_SQUARES / 2),
        child: Stack(children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: categoryIcon != null && categoryName != null
                  ? Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(right: 1),
                            child: Icon(
                              categoryIcon!,
                              size: 18,
                            )),
                        Text(categoryName!, style: TextStyle(fontSize: 18)),
                      ],
                    )
                  : Container()),
          Center(
              child: AutoSizeText(
            name,
            maxLines: 2,
            minFontSize: 25,
            textAlign: TextAlign.center,
            wrapWords: true,
            overflow: TextOverflow.fade,
          ))
        ])
            .card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 1,
        )
            .gestures(onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return child;
          }));
        }));
  }
}
