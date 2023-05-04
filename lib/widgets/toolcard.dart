import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mathx_android/constants.dart';
import 'package:styled_widget/styled_widget.dart';

class ToolCard extends StatelessWidget {
  ToolCard({Key? key, required this.name, required this.child})
      : super(key: key);

  late String name;
  late Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(PADDING_BETWEEN_SQUARES / 2),
        child: Center(
                child: AutoSizeText(
          name,
          maxLines: 2,
          minFontSize: 25,
          textAlign: TextAlign.center,
          wrapWords: true,
          overflow: TextOverflow.fade,
        ))
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
