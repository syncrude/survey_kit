import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/result/survey_result.dart';
import 'package:survey_kit/src/model/step.dart';

@immutable
class SurveyState {
  final List<Step> steps; // List of steps in the survey.
  final Set<StepResult> questionResults; // Set of question results.
  final Step? currentStep; // Current step in the survey.
  final StepResult? result; // Result of the current step/question.
  final int currentStepIndex; // Index of the current step.
  final int stepCount; // Total number of steps in the survey.
  final SurveyResult? surveyResult; // Result of the survey.
  final bool isLoading; // Flag to indicate loading state.

  const SurveyState({
    required this.stepCount,
    required this.currentStep,
    required this.steps,
    required this.questionResults,
    this.result,
    this.currentStepIndex = 0,
    this.surveyResult,
    this.isLoading = false,
  });

  @override
  bool operator ==(Object other) =>
      other is SurveyState &&
      other.stepCount == stepCount &&
      other.currentStep == currentStep &&
      other.steps == steps &&
      other.questionResults == questionResults &&
      other.result == result &&
      other.currentStepIndex == currentStepIndex &&
      other.surveyResult == surveyResult &&
      other.isLoading == isLoading;
  @override
  int get hashCode =>
      stepCount.hashCode ^
      currentStep.hashCode ^
      steps.hashCode ^
      questionResults.hashCode ^
      result.hashCode ^
      currentStepIndex.hashCode ^
      surveyResult.hashCode ^
      isLoading.hashCode;

  // This method is used to create a new instance of SurveyState with updated properties.
  //  Each property is checked against the provided value, and if it is null, the existing value is used.
  // If a non-null value is provided, it is used instead of the existing value.
  SurveyState copyWith({
    int? stepCount, // the count of the steps in the survey.
    Step? currentStep, // the current step in the survey.
    List<Step>? steps, // the list of steps in the survey.
    Set<StepResult>? questionResults, // the set of question results.
    StepResult? result, // the result of the current step/question.
    int? currentStepIndex, // the index of the current step.
    SurveyResult? surveyResult, // the result of the survey.
    bool? isLoading, // the loading state.
  }) =>
      SurveyState(
        stepCount: stepCount ?? this.stepCount,
        currentStep: currentStep ?? this.currentStep,
        steps: steps ?? this.steps,
        questionResults: questionResults ?? this.questionResults,
        result: result ?? this.result,
        currentStepIndex: currentStepIndex ?? this.currentStepIndex,
        surveyResult: surveyResult ?? this.surveyResult,
        isLoading: isLoading ?? this.isLoading,
      );

  bool get isFirstStep =>
      currentStepIndex ==
      0; // Check if the current step index is 0, indicating that it is the first step.
  double get progress =>
      currentStepIndex /
      stepCount; // Calculate the progress by dividing the current step index by the total step count.
}
