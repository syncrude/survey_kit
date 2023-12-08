import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/presenter/survey_event.dart';
import 'package:survey_kit/src/presenter/survey_state_provider.dart';

class SurveyController {
  /// Defines what should happen if the next step is called
  /// Default behavior is:
  /// ```dart
  /// BlocProvider.of<SurveyPresenter>(context).add(
  ///    NextStep(
  ///      resultFunction.call(),
  ///    ),
  /// );
  /// ```
  final Function(
    BuildContext context,
    StepResult? stepResult,
  )? onNextStep;

  /// Defines what should happen if the previous step is called
  /// Default behavior is:
  /// ```dart
  /// BlocProvider.of<SurveyPresenter>(context).add(
  ///    StepBack(
  ///      resultFunction.call(),
  ///    ),
  /// );
  /// ```
  final Function(
    BuildContext context,
    StepResult? stepResult,
  )? onStepBack;

  /// Defines what should happen if the survey should be closed
  /// Default behavior is:
  /// ```dart
  /// BlocProvider.of<SurveyPresenter>(context).add(
  ///    CloseSurvey(
  ///      resultFunction.call(),
  ///    ),
  /// );
  /// ```
  final Function(
    BuildContext context,
    StepResult? stepResult,
  )? onCloseSurvey;

  SurveyController({
    this.onNextStep,
    this.onStepBack,
    this.onCloseSurvey,
  });

  // The `nextStep` method is used to navigate to the next step in the survey.
  // It takes in the `BuildContext` and an optional `StepResult` as parameters.
  // If `onNextStep` callback is provided, it calls the callback with the context and step result.
  // Otherwise, it triggers the `NextStep` event on the `SurveyStateProvider` using `onEvent`.
  void nextStep(
    BuildContext context,
    StepResult? stepResult,
  ) {
    if (onNextStep != null) {
      onNextStep!(context, stepResult); // Call the onNextStep callback
      return;
    }
    Provider.of<SurveyStateProvider>(context, listen: false).onEvent(
      NextStep(
        stepResult,
      ),
    );
  }

  // The `stepBack` method is used to navigate back to the previous step in the survey.
  // It takes in the `BuildContext` and an optional `StepResult` as parameters.
  // If `onStepBack` callback is provided, it calls the callback with the context and step result.
  // Otherwise, it triggers the `StepBack` event on the `SurveyStateProvider` using `onEvent`.
  void stepBack({
    required BuildContext context,
    StepResult? stepResult,
  }) {
    if (onStepBack != null) {
      onStepBack!(context, stepResult); // Call the onStepBack callback
      return;
    }
    Provider.of<SurveyStateProvider>(context, listen: false).onEvent(
      StepBack(
        stepResult,
      ),
    );
  }

  // The `closeSurvey` method is used to close the survey and perform any necessary actions.
  // It takes in the `BuildContext` and an optional `StepResult` as parameters.
  // If `onCloseSurvey` callback is provided, it calls the callback with the context and step result.
  // Otherwise, it triggers the `CloseSurvey` event on the `SurveyStateProvider` using `onEvent`.
  void closeSurvey({
    required BuildContext context,
    StepResult? stepResult,
  }) {
    if (onCloseSurvey != null) {
      onCloseSurvey!(context, stepResult); // Call the onCloseSurvey callback
      return;
    }
    Provider.of<SurveyStateProvider>(context, listen: false).onEvent(
      CloseSurvey(
        stepResult,
      ),
    );
  }
}
