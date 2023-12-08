import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:provider/provider.dart';
import 'package:survey_kit/survey_kit.dart';

// ignore: must_be_immutable
class SurveyStateProvider extends ChangeNotifier {
  SurveyStateProvider({
    required this.taskNavigator,
    required this.onResult,
    required this.navigatorKey,
    this.stepShell,
  }) : startDate = DateTime.now();

  final TaskNavigator taskNavigator; // The task navigator.
  final Function(SurveyResult) onResult; // The onResult callback.
  final StepShell? stepShell; // The step shell.
  final GlobalKey<NavigatorState> navigatorKey; // The navigator key.

  SurveyState? _state; // The current SurveyState.
  SurveyState? get state => _state; // Getter for the current SurveyState.
  // This method is used to update the current SurveyState.
  void updateState(SurveyState newState) {
    _state = newState;
    notifyListeners();
  }

  // This method is used to get the SurveyState from the current BuildContext.
  static SurveyState? of(BuildContext context) {
    return Provider.of<SurveyStateProvider>(context, listen: false).state;
  }

  Set<StepResult> results = {}; // Set of question results.
  late final DateTime startDate; // Start date of the survey.

  // This method is used to handle events from the survey.
  void onEvent(SurveyEvent event) {
    // If the event is StartSurvey, call the _handleInitialStep method and update the state.
    if (event is StartSurvey) {
      final newState = _handleInitialStep();
      updateState(newState);
      return;
    }
    // If the event is not StartSurvey, make sure the current state is not null.
    if (state != null) {
      // If the event is NextStep, call the _handleNextStep method and update the state.
      if (event is NextStep) {
        final newState = _handleNextStep(event, state!);
        updateState(newState);
        navigatorKey.currentState?.pushNamed(
          '/${newState.currentStep?.id}',
          arguments: newState,
        );
        return;
      } else if (event is StepBack) {
        // If the event is StepBack, call the handleStepBack method and update the state.
        final newState = handleStepBack(event, state!);
        updateState(newState);
        navigatorKey.currentState?.pop();
        return;
      } else if (event is CloseSurvey) {
        // If the event is CloseSurvey, call the _handleClose method and update the state.
        final newState = _handleClose(event, state!);
        updateState(newState);
        navigatorKey.currentState?.pop();
        return;
      }
    }
  }

  // This creates the initial SurveyState and returns it.
  SurveyState _handleInitialStep() {
    // Get the first step in the task navigation.
    final step = taskNavigator.firstStep();
    // Make sure the step is not null, and if it is, throw an exception.
    assert(step != null, 'No steps provided');
    // If the step is not null, return a new SurveyState with the currentStep, result, and currentStepIndex set.
    if (step != null) {
      return SurveyState(
        currentStep: step,
        questionResults: results,
        steps: taskNavigator.task.steps,
        result: null,
        currentStepIndex: currentStepIndex(step),
        stepCount: countSteps,
      );
    }

    throw Exception('No steps provided');
  }

  // This handles the event of going forward to the next step and returns an updated SurveyState.
  SurveyState _handleNextStep(
    NextStep event,
    SurveyState currentState,
  ) {
    // Add the questionResult from the event to the results list.
    _addResult(event.questionResult);
    // Get the next step in the task navigation.
    final nextStep = taskNavigator.nextStep(
      step: currentState.currentStep!,
      previousResults: results.toList(),
      questionResult: event.questionResult,
    );

    // If there's no next step, we are finished with the survey.
    if (nextStep == null) {
      return _handleSurveyFinished(currentState);
    }

    // Get the questionResult for the next step.
    final questionResult = _getResultByStepIdentifier(nextStep.id);

    // Return a new SurveyState with the updated currentStep, result, and currentStepIndex.
    return SurveyState(
      currentStep: nextStep,
      result: questionResult,
      steps: taskNavigator.task.steps,
      questionResults: results,
      currentStepIndex: currentStepIndex(nextStep),
      stepCount: countSteps,
    );
  }

  // This handles the event of going back to the previous step and returns an updated SurveyState.
  SurveyState handleStepBack(
    StepBack event,
    SurveyState currentState,
  ) {
    // Add the questionResult from the event to the results list.
    _addResult(event.questionResult);
    // Get the previous step in the task navigation.
    final previousStep =
        taskNavigator.previousInList(currentState.currentStep!);

    // If theres no previous step we can't go back further
    if (previousStep != null) {
      final questionResult = _getResultByStepIdentifier(previousStep.id);

      return state!.copyWith(
        currentStep: previousStep,
        result: questionResult,
        steps: taskNavigator.task.steps,
        questionResults: results,
        currentStepIndex: currentStepIndex(previousStep),
        stepCount: countSteps,
      );
    }
    // If there's no previous step, return the current state without any changes.
    return state!;
  }

  // This method retrieves a StepResult from the results list based on the provided step identifier.
  StepResult? _getResultByStepIdentifier(String? identifier) {
    return results.firstWhereOrNull(
      (element) => element.id == identifier,
    );
  }

  // This method handles the event of closing the survey and returns an updated SurveyState.
  SurveyState _handleClose(
    CloseSurvey event,
    SurveyState currentState,
  ) {
    // Add the questionResult from the event to the results list.
    _addResult(event.questionResult);

    // Create a new list of step results by mapping the existing results.
    final stepResults = results.map((e) => e).toList();

    // create the survey result
    final taskResult = SurveyResult(
      id: taskNavigator.task.id,
      startTime: startDate,
      endTime: DateTime.now(),
      finishReason: FinishReason.discarded,
      results: stepResults,
    );
    // Call the onResult callback with the task result.
    onResult(taskResult);
    // Set the survey result of the updated state to the created task result.
    return state!.copyWith(surveyResult: taskResult);
  }

  // This method handles the survey finishing process and returns an updated SurveyState.
  //Currently we are only handling one question per step
  SurveyState _handleSurveyFinished(SurveyState currentState) {
    final stepResults = results.map((e) => e).toList();
    final taskResult = SurveyResult(
      id: taskNavigator.task.id,
      startTime: startDate,
      endTime: DateTime.now(),
      finishReason: FinishReason.completed,
      results: stepResults,
    );

    onResult(taskResult); // Call the onResult callback with the task result.
    // Return a new SurveyState with the updated surveyResult.
    return state!.copyWith(
      surveyResult: taskResult,
      currentStep: currentState.currentStep,
      result: currentState.result,
    );
  }

  // is method is responsible for adding a StepResult to the results list. It takes a questionResult as a parameter.
  void _addResult(StepResult? questionResult) {
    if (questionResult == null) {
      return;
    }
    // Add the questionResult to the results list.
    results
      ..removeWhere((StepResult result) => result.id == questionResult.id)
      ..add(
        questionResult,
      );
  }

  int get countSteps => taskNavigator.countSteps; // the count of the steps.
  int currentStepIndex(Step step) {
    // the index of the current step.
    return taskNavigator.currentStepIndex(step);
  }

  StepResult? getStepResultById(String id) {
    return results.firstWhereOrNull((element) => element.id == id);
  }
}

// // Extension method to get the SurveyStateProvider from the current BuildContext.
extension SurveyStateExt on BuildContext {
  SurveyStateProvider get surveyStateProvider =>
      Provider.of<SurveyStateProvider>(this, listen: false);
}
