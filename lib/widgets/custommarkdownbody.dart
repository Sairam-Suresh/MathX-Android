import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

MarkdownBody buildMarkdownBody(String text, bool isDarkMode) {
  return MarkdownBody(
    data: text,
    shrinkWrap: true,
    onTapLink: (text, link, _) {
      if ((link ?? "") != "") {
        _launchUrl(Uri.parse(link!));
      }
    },
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
