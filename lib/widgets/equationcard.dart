import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class EquationCard extends StatelessWidget {
  const EquationCard({super.key, required this.text, this.labelText});

  final String text;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (labelText != null)
                    Text(
                      labelText!,
                      style: const TextStyle(fontSize: 10),
                    ),
                  if (labelText != null)
                    const Divider(
                      height: 5,
                    ),
                  if (labelText != null)
                    const SizedBox(
                      height: 10,
                    ),
                  Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Math.tex(
                        text,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}
