import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class EquationCard extends StatelessWidget {
  const EquationCard({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Math.tex(
                    text,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                ),
              ))),
    );
  }
}
