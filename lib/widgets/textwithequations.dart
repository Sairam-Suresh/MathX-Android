import 'package:flutter/material.dart';
import 'package:mathx_android/widgets/custommarkdownbody.dart';

class TextWithEquations extends StatelessWidget {
  final String text;

  TextWithEquations({required this.text});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return buildMarkdownBody(text, isDarkMode, true);
  }
}
