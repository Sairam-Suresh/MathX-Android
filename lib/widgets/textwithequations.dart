import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class TextWithEquations extends StatelessWidget {
  final String text;

  TextWithEquations({required this.text});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final pattern = RegExp(r'\\\[([\s\S]*?)\\\]');

    final matches = pattern.allMatches(text);
    final equationIndices = matches.map((match) => match.start).toList();

    final List<Widget> children = [];

    if (equationIndices.isEmpty) {
      children.add(
        buildMarkdownBody(text, isDarkMode),
      );
    } else {
      int currentIndex = 0;

      for (final equationIndex in equationIndices) {
        if (currentIndex != equationIndex) {
          final regularText = text.substring(currentIndex, equationIndex);
          children.add(buildMarkdownBody(regularText, isDarkMode));
        }

        final equationMatch =
            matches.firstWhere((match) => match.start == equationIndex);
        final equationText = equationMatch.group(1)!;
        children.add(Math.tex(equationText));

        currentIndex = equationIndex + equationMatch.group(0)!.length;
      }

      if (currentIndex < text.length) {
        final remainingText = text.substring(currentIndex);
        children.add(buildMarkdownBody(remainingText, isDarkMode));
      }
    }

    return Wrap(
      children: children,
    );
  }

  MarkdownBody buildMarkdownBody(String text, bool isDarkMode) {
    return MarkdownBody(
      data: text,
      shrinkWrap: true,
      styleSheet: MarkdownStyleSheet(
        blockquoteDecoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: Colors.grey.shade300, width: 2.0),
          ),
        ),
        blockquotePadding: const EdgeInsets.all(8.0),
        checkbox: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
      ),
    );
  }
}
