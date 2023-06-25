import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:swipe_cards/swipe_cards.dart';

var allNotes = [
  [
    "Numbers and Their Operations Part 1",
    "Numbers and Their Operations Part 2",
    "Percentages",
    "Basic Algebra and Algebraic Manipulation",
    "Linear Equations and Inequalities",
    "Functions and Linear Graphs",
    "Basic Geometry",
    "Polygons",
    "Geometrical Construction",
    "Number Sequences",
  ],
  [
    "Similarity and Congruence Part 1",
    "Similarity and Congruence Part 2",
    "Ratio and Prorortion",
    "Direct and Inverse Proportions",
    "Pythagoras Theorem",
    "Trigonometric Ratios",
  ],
  [
    "Indices",
    "Surds",
    "Functions and Graphs",
    "Quadratic Funcations, Equations, and Inequalities",
    "Coordinate Geometry",
    "Exponentials and Logarithms",
    "Futher Coordinate Geometry",
    "Linear Law",
    "Geometrical Properties of Circles"
  ]
];

class CheatsheetDetail {
  final String title;
  final String notePath;

  CheatsheetDetail(this.title, this.notePath);
}

class CheatsheetLevel {
  final int level;
  final List<CheatsheetDetail> cheatsheets;

  CheatsheetLevel(this.level, this.cheatsheets);
}

var cheatsheetsData = [
  CheatsheetLevel(1, [
    CheatsheetDetail("sec1 topic1", "pdfs/testpdf.pdf"),
    CheatsheetDetail("sec1 topic2", "pdfs/testpdf.pdf"),
    CheatsheetDetail("sec1 topic3", "pdfs/testpdf.pdf"),
    CheatsheetDetail("sec1 topic4", "pdfs/testpdf.pdf"),
  ]),
  CheatsheetLevel(2, [
    CheatsheetDetail("sec2 topic1", "pdfs/testpdf.pdf"),
    CheatsheetDetail("sec2 topic2", "pdfs/testpdf.pdf"),
    CheatsheetDetail("sec2 topic3", "pdfs/testpdf.pdf"),
    CheatsheetDetail("sec2 topic4", "pdfs/testpdf.pdf"),
  ]),
  CheatsheetLevel(3, [
    CheatsheetDetail("sec3 topic1", "pdfs/testpdf.pdf"),
    CheatsheetDetail("sec3 topic2", "pdfs/testpdf.pdf"),
    CheatsheetDetail("sec3 topic3", "pdfs/testpdf.pdf"),
    CheatsheetDetail("sec3 topic4", "pdfs/testpdf.pdf"),
  ]),
  CheatsheetLevel(4, [
    CheatsheetDetail("sec4 topic1", "pdfs/testpdf.pdf"),
    CheatsheetDetail("sec4 topic2", "pdfs/testpdf.pdf"),
    CheatsheetDetail("sec4 topic3", "pdfs/testpdf.pdf"),
    CheatsheetDetail("sec4 topic4", "pdfs/testpdf.pdf"),
  ]),
];

class CheatsheetPage extends StatefulWidget {
  const CheatsheetPage({super.key});

  @override
  State<CheatsheetPage> createState() => _CheatsheetPageState();
}

class _CheatsheetPageState extends State<CheatsheetPage> {
  final pagePosition = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("")),
      body: Carousel(),
    );
  }
}

class Carousel extends StatefulWidget {
  const Carousel({
    Key? key,
  }) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late PageController _pageController;

  int activePage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9, initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(right: 10, left: 10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4 * 3,
            child: PageView.builder(
              itemCount: allNotes.length,
              pageSnapping: true,
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  activePage = page;
                });
              },
              itemBuilder: (context, pagePosition) {
                bool active = pagePosition == activePage;
                return slider(pagePosition, active);
              },
            ),
          ),
        ),
      ],
    );
  }
}

AnimatedContainer slider(pagePosition, active) {
  double margin = 10;

  return AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOutCubic,
    margin: EdgeInsets.all(margin),
    child: Column(
      children: [
        Text(
          "Secondary ${pagePosition + 1}",
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 5),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: Colors.purple,
            ),
            padding: const EdgeInsets.all(20),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: allNotes[pagePosition].length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.purpleAccent,
                  margin: EdgeInsets.only(bottom: 15),
                  child: ListTile(
                    title: Text(allNotes[pagePosition][index]),
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyPdfViewer(
                              pdfPath: allNotes[pagePosition][index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}

imageAnimation(PageController animation, images, pagePosition) {
  return AnimatedBuilder(
    animation: animation,
    builder: (context, widget) {
      return SizedBox(
        width: 200,
        height: 200,
        child: widget,
      );
    },
    child: Container(
      margin: EdgeInsets.all(10),
      child: Image.network(images[pagePosition]),
    ),
  );
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(
    imagesLength,
    (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    },
  );
}

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
