import 'dart:collection';

import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/task/task.dart';

// This class represents a navigator for a task.
abstract class TaskNavigator {
  final Task task; // The task associated with the navigator.
  final ListQueue<Step> history =
      ListQueue(); // A queue to store the history of steps.

  TaskNavigator(this.task);

  // Method to determine the first step in the task navigation.
  Step? firstStep();
  // Method to determine the next step in the task navigation.
  Step? nextStep({
    required Step step,
    required List<StepResult> previousResults,
    StepResult? questionResult,
  });

  // Method to determine the previous step in the task navigation.
  Step? previousInList(Step step);

  // Method to get the next step in the list based on the current step.
  Step? nextInList(Step? step) {
    final currentIndex = task.steps.indexWhere(
      (element) => element.id == step?.id,
    );
    return (currentIndex + 1 > task.steps.length - 1)
        ? null
        : task.steps[currentIndex + 1];
  }

  // Method to get the last step recorded in the history.
  Step? peekHistory() {
    if (history.isEmpty) {
      return null;
    }
    return history.last;
  }

  // Method to check if there is a previous step in the history.
  bool hasPreviousStep() {
    final step = peekHistory();
    return step != null;
  }

  // Method to record a step in the history.
  void record(Step step) {
    history.add(step);
  }

  int get countSteps => task.steps.length; // the total number of steps
  int currentStepIndex(Step step) {
    // the index of the current step
    return task.steps.indexOf(step);
  }
}
