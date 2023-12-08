import 'package:flutter/material.dart' hide Step;
import 'package:provider/provider.dart';
import 'package:survey_kit/src/view/step_view.dart';
import 'package:survey_kit/survey_kit.dart';

/// The `AnswerView` widget represents a view for answering a survey question.
class AnswerView extends StatefulWidget {
  const AnswerView({
    super.key,
    required this.answer,
    required this.step,
    required this.stepResult,
  });
  final AnswerFormat? answer; // The answer format of the current step.

  final Step step; // The current step in the survey.
  final StepResult? stepResult; // The result of the current step.

  @override
  State<AnswerView> createState() => _AnswerViewState();
}

class _AnswerViewState extends State<AnswerView> {
  @override
  Widget build(BuildContext context) {
    Widget? answerView; // Variable to hold the answer view widget.
    // Create the answer view using the `createView` method of the answer.
    if (widget.answer != null) {
      answerView = widget.answer!.createView(widget.step, widget.stepResult);
    }
    // Get the step shell from the current step or from the `SurveyStateProvider`.
    final stepShell = widget.step.stepShell ??
        Provider.of<SurveyStateProvider>(context).stepShell;

    // Pass the current step to the `QuestionAnswer` widget.
    // If a step shell is available, call it with the current step, answer view, and context.
    // If no step shell is available, use the default `StepView` widget.
    return QuestionAnswer<dynamic>(
      step: widget.step,
      child: Builder(
        builder: (context) => stepShell != null
            ? stepShell.call(
                widget.step,
                answerView,
                context,
              )
            : StepView(
                step: widget.step,
                answerView: answerView,
              ),
      ),
    );
  }
}
