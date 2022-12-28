import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class SurveyKitMarkdown extends StatelessWidget {
  const SurveyKitMarkdown({
    super.key,
    required this.markdown,
  });

  final String markdown;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: MarkdownBody(
        data: markdown,
        selectable: true,
      ),
    );
  }
}