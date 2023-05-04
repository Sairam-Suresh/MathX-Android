import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/HCFLCM.dart';
import 'package:styled_widget/styled_widget.dart';

class NoteCard extends StatelessWidget {
  NoteCard({Key? key, required this.name}) : super(key: key);

  late String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(PADDING_BETWEEN_SQUARES / 2),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 1,
        child: Padding(
          padding: EdgeInsets.all(PADDING_BETWEEN_SQUARES),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoSizeText(
                  name,
                  maxLines: 2,
                  minFontSize: 25,
                  textAlign: TextAlign.left,
                  wrapWords: true,
                  overflow: TextOverflow.fade,
                ),
                AutoSizeText(
                  name,
                  maxLines: 2,
                  minFontSize: 15,
                  textAlign: TextAlign.left,
                  wrapWords: true,
                  overflow: TextOverflow.fade,
                )
              ]).gestures(onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              // TODO: Make this push to a dedicated page which edits the data
              return const HCFLCMPage();
            }));
          }),
        ),
      ),
    );
  }
}
