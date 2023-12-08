import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/survey_kit.dart';

/// The purpose of the StepShell typedef is to provide a flexible way to wrap a step view with additional
/// functionality or customization. It allows developers to define their own custom widgets or functions
/// that conform to this signature and can be used as a shell around the step view. This can be useful for
/// implementing features such as step validation, progress indicators, navigation controls,
/// or any other custom behavior specific to a step in the survey.
typedef StepShell = Widget Function({
  required Step step,
  required Widget child,
  StepResult Function()? resultFunction,
  bool isValid,
  SurveyController? controller,
});

/// The StepView is responsible for displaying the content of a survey step.
/// It is also responsible for handling the user's input for a survey step.
/// It also keeps track of the time the widget is existing and used for a survey step.
class StepView extends StatefulWidget {
  final Step step; // the step to be displayed
  final Widget? answerView; // the answer view to be displayed
  final SurveyController? controller; // the survey controller

  const StepView({
    super.key,
    required this.step,
    this.answerView,
    this.controller,
  });

  @override
  State<StepView> createState() => _StepViewState();
}

class _StepViewState extends State<StepView> {
  final startTime = DateTime.now(); // the start time of the step

  @override
  Widget build(BuildContext context) {
    final surveyConfiguration =
        SurveyConfiguration.of(context); // the survey configuration
    // the survey controller, from the widget or from the survey configuration
    final _surveyController =
        widget.controller ?? surveyConfiguration.surveyController;

    // the question answer, from the context
    final questionAnswer = QuestionAnswer.of(context);

    return ColoredBox(
      color: Theme.of(context).colorScheme.background,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Padding(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: constraint.maxHeight - 60),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // this shows the context of the step.
                        Expanded(
                          child: ContentWidget(
                            content: widget.step.content,
                          ),
                        ),
                        // this shows the answer view of the step (if it exists)
                        if (widget.answerView != null) widget.answerView!,
                        // this shows the navigation controls of the step
                        AnimatedBuilder(
                          animation: questionAnswer.isValid,
                          builder: (context, child) {
                            return OutlinedButton(
                              onPressed: questionAnswer.isValid.value ||
                                      !widget.step.isMandatory
                                  ? () => _surveyController.nextStep(
                                        context,
                                        questionAnswer.stepResult,
                                      )
                                  : null,
                              child: Text(
                                widget.step.buttonText ??
                                    surveyConfiguration.localizations?['next']
                                        ?.toUpperCase() ??
                                    'Next',
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
