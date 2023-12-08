import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/navigator/task_navigator.dart';
import 'package:survey_kit/src/task/task.dart';

// This class represents a navigator for an ordered task.
class OrderedTaskNavigator extends TaskNavigator {
  OrderedTaskNavigator(Task task) : super(task);

  // Override the nextStep method to determine the next step in the task navigation.
  @override
  Step? nextStep({
    required Step step,
    required List<StepResult> previousResults,
    StepResult? questionResult,
  }) {
    record(step); // Record the current step in the history.
    return nextInList(step); // Return the next step in the list.
  }

  // Override the previousInList method to determine the previous step in the task navigation.
  @override
  Step? previousInList(Step step) {
    final currentIndex = task.steps.indexWhere(
      (element) => element.id == step.id,
    ); // Find the index of the current step in the task.steps list.
    return (currentIndex - 1 < 0)
        ? null
        : task.steps[currentIndex -
            1]; // Return the previous step if it exists, otherwise return null.
  }

  // Override the firstStep method to determine the first step in the task navigation.
  @override
  Step? firstStep() {
    final previousStep =
        peekHistory(); // Get the previous step from the history.
    return previousStep == null
        ? task.initalStep ??
            task.steps
                .first // If there is no previous step, return the initial step if available, otherwise return the first step in the task.
        : nextInList(
            previousStep,
          ); // Return the next step based on the previous step.
  }
}
