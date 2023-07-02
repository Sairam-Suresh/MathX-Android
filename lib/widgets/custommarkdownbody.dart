import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:markdown_widget/markdown_widget.dart';

MarkdownWidget buildMarkdownBody(
    String text, bool isDarkMode, bool? renderEquations) {
  return MarkdownWidget(
    data: text,
    shrinkWrap: true,
    config: isDarkMode
        ? MarkdownConfig.darkConfig.copy(
            configs: [const CustomH1Config(style: TextStyle(fontSize: 32))])
        : MarkdownConfig.defaultConfig.copy(
            configs: [const CustomH1Config(style: TextStyle(fontSize: 32))]),
    markdownGeneratorConfig: (renderEquations) ?? false
        ? MarkdownGeneratorConfig(
            generators: [latexGenerator], inlineSyntaxList: [LatexSyntax()])
        : null,
  );
}

class CustomH1Config with HeadingConfig {
  @override
  final TextStyle style;

  const CustomH1Config(
      {this.style = const TextStyle(
        fontSize: 32,
        height: 40 / 32,
        fontWeight: FontWeight.bold,
      )});

  @nonVirtual
  @override
  String get tag => MarkdownTag.h1.name;

  static H1Config get darkConfig => const H1Config(
          style: TextStyle(
        fontSize: 32,
        height: 40 / 32,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ));

  @override
  HeadingDivider? get divider =>
      HeadingDivider(height: 0, color: Colors.transparent);
}

// All custom code required to add LaTeX support
SpanNodeGeneratorWithTag latexGenerator = SpanNodeGeneratorWithTag(
    tag: _latexTag,
    generator: (e, config, visitor) =>
        LatexNode(e.attributes, e.textContent, config));

const _latexTag = 'latex';

class LatexSyntax extends md.InlineSyntax {
  LatexSyntax() : super(r'(\$\$[\s\S]+\$\$)|(\$.+?\$)');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final input = match.input;
    final matchValue = input.substring(match.start, match.end);
    String content = '';
    bool isInline = true;
    const blockSyntax = '\$\$';
    const inlineSyntax = '\$';
    if (matchValue.startsWith(blockSyntax) &&
        matchValue.endsWith(blockSyntax) &&
        (matchValue != blockSyntax)) {
      content = matchValue.substring(2, matchValue.length - 2);
      isInline = false;
    } else if (matchValue.startsWith(inlineSyntax) &&
        matchValue.endsWith(inlineSyntax) &&
        matchValue != inlineSyntax) {
      content = matchValue.substring(1, matchValue.length - 1);
    }
    md.Element el = md.Element.text(_latexTag, matchValue);
    el.attributes['content'] = content;
    el.attributes['isInline'] = '$isInline';
    parser.addNode(el);
    return true;
  }
}

class LatexNode extends SpanNode {
  final Map<String, String> attributes;
  final String textContent;
  final MarkdownConfig config;

  LatexNode(this.attributes, this.textContent, this.config);

  @override
  InlineSpan build() {
    final content = attributes['content'] ?? '';
    final isInline = attributes['isInline'] == 'true';
    final style = parentStyle ?? config.p.textStyle;
    if (content.isEmpty) return TextSpan(style: style, text: textContent);
    final latex = Math.tex(
      content,
      mathStyle: MathStyle.text,
      textStyle: style,
      textScaleFactor: 1,
      onErrorFallback: (error) {
        return Text(
          textContent,
          style: style.copyWith(color: Colors.red),
        );
      },
    );
    return WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: !isInline
            ? Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: Center(child: latex),
              )
            : latex);
  }
}
