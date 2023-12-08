import 'package:flutter/material.dart';

/// This widget displays the provided text as a Text widget.
class AnswerQuestionText extends StatelessWidget {
  const AnswerQuestionText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(text), // Display the provided text as a Text widget.
    );
  }
}
