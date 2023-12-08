import 'package:survey_kit/src/model/result/step_result.dart';

// Abstract base class for survey events.
abstract class SurveyEvent {
  const SurveyEvent();
}

// Event indicating the start of the survey.
class StartSurvey extends SurveyEvent {}

// Event indicating the transition to the next step in the survey.
class NextStep extends SurveyEvent {
  final StepResult? questionResult; // Result of the current step/question.

  NextStep(
    this.questionResult,
  ); // Constructor to initialize the question result.
}

// Event indicating the transition to the previous step in the survey.
class StepBack extends SurveyEvent {
  final StepResult? questionResult; // Result of the current step/question.

  StepBack(
    this.questionResult,
  ); // Constructor to initialize the question result.
}

// Event indicating the closure of the survey.
class CloseSurvey extends SurveyEvent {
  final StepResult? questionResult; // Result of the current step/question.

  CloseSurvey(
    this.questionResult,
  ); // Constructor to initialize the question result.
}
