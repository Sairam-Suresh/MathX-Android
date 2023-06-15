import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mathx_android/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class CheatSheetViewer extends HookWidget {
  const CheatSheetViewer(
      {super.key, required this.cheatsheet, required this.onToggleStarred});

  final CheatsheetDetails cheatsheet;
  final void Function(bool isStarred) onToggleStarred;

  @override
  Widget build(BuildContext context) {
    AsyncSnapshot<Directory> getAppDir =
        useFuture(getApplicationDocumentsDirectory());

    var starred = useState(cheatsheet.isStarred);

    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          cheatsheet.title,
          maxLines: 1,
        ),
        actions: [
          IconButton(
            onPressed: () {
              starred.value = !starred.value;
              onToggleStarred(starred.value);
            },
            icon: starred.value
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border),
          )
        ],
      ),
      body: getAppDir.hasData
          ? Stack(
              children: [
                PdfView(
                    gestureNavigationEnabled: true,
                    path:
                        "${(getAppDir.data!).toString().replaceAll("Directory: '", "").replaceAll("'", "")}/cheatsheets/${cheatsheet.title}.pdf"),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
