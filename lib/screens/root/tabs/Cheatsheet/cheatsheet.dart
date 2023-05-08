import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class CheatsheetDetail {
  final String title;
  final String notePath;

  CheatsheetDetail(this.title, this.notePath);
}

var cheatsheetsData = [
  [
    CheatsheetDetail("sec1 topic1", "pdfs/testpdf.pdf"),
    CheatsheetDetail("sec1 topic2", "pdfs/testpdf.pdf"),
    CheatsheetDetail("sec1 topic3", "pdfs/testpdf.pdf"),
    CheatsheetDetail("sec1 topic4", "pdfs/testpdf.pdf"),
  ],
  [
    CheatsheetDetail("sec2 topic1", "pdfs/testpdf.pdf"),
    CheatsheetDetail("sec2 topic2", "pdfs/testpdf.pdf"),
    CheatsheetDetail("sec2 topic3", "pdfs/testpdf.pdf"),
    CheatsheetDetail("sec2 topic4", "pdfs/testpdf.pdf"),
  ],
  [
    CheatsheetDetail("sec3 topic1", "pdfs/testpdf.pdf"),
    CheatsheetDetail("sec3 topic2", "pdfs/testpdf.pdf"),
    CheatsheetDetail("sec3 topic3", "pdfs/testpdf.pdf"),
    CheatsheetDetail("sec3 topic4", "pdfs/testpdf.pdf"),
  ],
  [
    CheatsheetDetail("sec4 topic1", "pdfs/testpdf.pdf"),
    CheatsheetDetail("sec4 topic2", "pdfs/testpdf.pdf"),
    CheatsheetDetail("sec4 topic3", "pdfs/testpdf.pdf"),
    CheatsheetDetail("sec4 topic4", "pdfs/testpdf.pdf"),
  ],
];

class CheatsheetPage extends StatelessWidget {
  const CheatsheetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cheatsheets"),
      ),
      body: ListView.builder(
          itemCount: 4,
          itemBuilder: (BuildContext buildContext, int index) {
            return ListTile(
              title: Text("Secondary ${index + 1}"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LevelCheatsheet(level: index)));
              },
            );
          }),
    );
  }
}

class LevelCheatsheet extends StatelessWidget {
  const LevelCheatsheet({super.key, required this.level});

  final int level;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Secondary ${level + 1}")),
      body: ListView.builder(
          itemCount: cheatsheetsData[level].length,
          itemBuilder: (BuildContext buildContext, int index) {
            return ListTile(
              title: Text(cheatsheetsData[level][index].title),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MyPdfViewer(pdfPath: 'assets/my_document.pdf')),
                );
              },
            );
          }),
    );
  }
}

// class CheatsheetDetailedView extends StatelessWidget {
//   const CheatsheetDetailedView(
//       {super.key, required this.level, required this.noteIndex});

//   final int level;
//   final int noteIndex;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(cheatsheetsData[level][noteIndex].title)),
//       body:
//     );
//   }
// }

class MyPdfViewer extends StatefulWidget {
  final String pdfPath;
  MyPdfViewer({required this.pdfPath});
  @override
  _MyPdfViewerState createState() => _MyPdfViewerState();
}

class _MyPdfViewerState extends State<MyPdfViewer> {
  late PDFViewController pdfViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My PDF Document"),
      ),
      body: PDFView(
        filePath: widget.pdfPath,
        autoSpacing: true,
        enableSwipe: true,
        pageSnap: true,
        swipeHorizontal: true,
        onError: (error) {
          debugPrint(error);
        },
        onPageError: (page, error) {
          debugPrint('$page: ${error.toString()}');
        },
        onViewCreated: (PDFViewController vc) {
          pdfViewController = vc;
        },
        onPageChanged: (int? page, int? total) {
          debugPrint('page change: $page/$total');
        },
      ),
    );
  }
}
