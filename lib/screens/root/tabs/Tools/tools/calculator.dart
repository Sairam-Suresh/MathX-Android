import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LayoutGrid(rowSizes: const [
      auto,
      auto,
      auto,
      auto,
      auto
    ], columnSizes: const [
      auto,
      auto,
      auto,
      auto,
      auto
    ], children: [
      // Row 1

      CalculatorButton(text: "a", onPressed: () {})
          .withGridPlacement(rowStart: 0, columnStart: 0),
      CalculatorButton(text: "a", onPressed: () {})
          .withGridPlacement(rowStart: 0, columnStart: 1),
      CalculatorButton(text: "a", onPressed: () {})
          .withGridPlacement(rowStart: 0, columnStart: 2),
      CalculatorButton(text: "a", onPressed: () {})
          .withGridPlacement(rowStart: 0, columnStart: 3),
      CalculatorButton(text: "a", onPressed: () {})
          .withGridPlacement(rowStart: 0, columnStart: 4),

      // Row 2
      CalculatorButton(text: "a", onPressed: () {})
          .withGridPlacement(rowStart: 1, columnStart: 0),
      CalculatorButton(text: "a", onPressed: () {})
          .withGridPlacement(rowStart: 1, columnStart: 1),
      CalculatorButton(text: "a", onPressed: () {})
          .withGridPlacement(rowStart: 1, columnStart: 2),
      CalculatorButton(text: "a", onPressed: () {})
          .withGridPlacement(rowStart: 1, columnStart: 3),
      CalculatorButton(text: "a", onPressed: () {})
          .withGridPlacement(rowStart: 1, columnStart: 4),

      // Row 3
      CalculatorButton(text: "a", onPressed: () {})
          .withGridPlacement(rowStart: 2, columnStart: 0),
      CalculatorButton(text: "a", onPressed: () {})
          .withGridPlacement(rowStart: 2, columnStart: 1),
      CalculatorButton(text: "a", onPressed: () {})
          .withGridPlacement(rowStart: 2, columnStart: 2),
      CalculatorButton(text: "a", onPressed: () {})
          .withGridPlacement(rowStart: 2, columnStart: 3),
      CalculatorButton(text: "a", onPressed: () {})
          .withGridPlacement(rowStart: 2, columnStart: 4),
      // Row 4
      CalculatorButton(text: "a", onPressed: () {})
          .withGridPlacement(rowStart: 3, columnStart: 0),
      CalculatorButton(text: "a", onPressed: () {})
          .withGridPlacement(rowStart: 3, columnStart: 1),
      CalculatorButton(text: "a", onPressed: () {})
          .withGridPlacement(rowStart: 3, columnStart: 2),
      CalculatorButton(text: "a", onPressed: () {})
          .withGridPlacement(rowStart: 3, columnStart: 3),
      CalculatorButton(text: "a", onPressed: () {})
          .withGridPlacement(rowStart: 3, columnStart: 4),
      // Row 5
      CalculatorButton(text: "a", onPressed: () {})
          .withGridPlacement(rowStart: 4, columnStart: 0, columnSpan: 2),
      CalculatorButton(text: "a", onPressed: () {})
          .withGridPlacement(rowStart: 4, columnStart: 2),
      CalculatorButton(text: "a", onPressed: () {})
          .withGridPlacement(rowStart: 4, columnStart: 3),
      CalculatorButton(text: "a", onPressed: () {})
          .withGridPlacement(rowStart: 4, columnStart: 4),
    ]));
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const CalculatorButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[300], // Background color
                  onPrimary: Colors.black, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Rounded corners
                  ),
                ),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
