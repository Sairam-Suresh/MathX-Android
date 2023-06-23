import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

MarkdownBody buildMarkdownBody(String text, bool isDarkMode) {
  return MarkdownBody(
    data: text,
    shrinkWrap: true,
    onTapLink: (text, link, _) {},
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
