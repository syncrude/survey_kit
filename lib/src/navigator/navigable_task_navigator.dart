import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/navigator/rules/conditional_navigation_rule.dart';
import 'package:survey_kit/src/navigator/rules/direct_navigation_rule.dart';
import 'package:survey_kit/src/navigator/task_navigator.dart';
import 'package:survey_kit/src/task/navigable_task.dart';
import 'package:survey_kit/src/task/task.dart';

class NavigableTaskNavigator extends TaskNavigator {
  NavigableTaskNavigator(Task task) : super(task);

  /// The nextStep method determines the next step in the task navigation based on the current step,
  /// previous results, and a question result. It checks if there is a navigation rule defined for the current step.
  /// If there is no rule, it returns the next step in the task's steps list.
  /// If there is a rule, it checks the type of the rule.
  /// If it is a direct navigation rule, it retrieves the destination step identifier from the rule and finds the
  /// corresponding step in the task's steps list.
  /// If it is a conditional navigation rule, it evaluates the next step based on the current step, the rule, and the previous results.
  @override
  Step? nextStep({
    required Step step,
    required List<StepResult> previousResults,
    StepResult? questionResult,
  }) {
    record(step);
    final navigableTask = task as NavigableTask;
    final rule = navigableTask.getRuleByStepIdentifier(step.id);
    if (rule == null) {
      return nextInList(step);
    }
    switch (rule.runtimeType) {
      case DirectNavigationRule:
        // The rule is of type `DirectNavigationRule`.
        // Retrieve the destination step identifier from the rule.
        // Find the first step in the task's steps list that matches the destination step identifier.
        // Return the found step as the next step.
        return task.steps.firstWhere(
          (element) =>
              element.id ==
              (rule as DirectNavigationRule).destinationStepIdentifier,
        );
      case ConditionalNavigationRule:
        // The rule is of type `ConditionalNavigationRule`.
        // Evaluate the next step based on the current step, the rule, and the previous results.
        // Call the `evaluateNextStep` method with the current step, the rule as `ConditionalNavigationRule`,
        // and the previous results to determine the next step.
        return evaluateNextStep(
          step,
          rule as ConditionalNavigationRule,
          previousResults,
          questionResult,
        );
    }
    // This code returns the next step in the list by calling the nextInList method with the current step.
    // when the rule is not of type `DirectNavigationRule` or `ConditionalNavigationRule`.
    return nextInList(step);
  }

  // It checks if the history list is empty. If it is, it returns null.
  // Otherwise, it removes and returns the last element from the history list.
  @override
  Step? previousInList(Step? step) {
    if (history.isEmpty) {
      return null;
    }
    return history.removeLast();
  }

  // contains the logic to evaluate the current step, the navigation rule,
  // and the previous results to determine the appropriate next step.
  Step? evaluateNextStep(
    Step? step,
    ConditionalNavigationRule rule,
    List<StepResult> previousResults,
    StepResult? questionResult,
  ) {
    // Get the next step identifier based on the rule, previous results, and question result
    final nextStepIdentifier =
        rule.resultToStepIdentifierMapper(previousResults, questionResult);
    if (nextStepIdentifier == null) {
      // If the next step identifier is null
      return nextInList(step); // Return the next step in the list
    }
    // Return the step with the matching next step identifier
    return task.steps.firstWhere((element) => element.id == nextStepIdentifier);
  }

  // firstStep method determines the first step in the task navigation.
  // If there is a previous step, it calculates the next step based on the previous step and other parameters.
  // If there is no previous step, it returns either the initial step or the first step in the task.
  @override
  Step? firstStep() {
    // Get the previous step from the history
    final previousStep = peekHistory();
    // If there is no previous step, return the initial step if available, otherwise return the first step in the task
    return previousStep == null
        ? task.initalStep ?? task.steps.first
        : nextStep(
            step: previousStep,
            previousResults: [],
            questionResult: null,
          ); // Return the next step based on the previous step, empty previous results, and null question result
  }
}
