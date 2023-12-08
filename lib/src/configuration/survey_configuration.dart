import 'package:flutter/material.dart';
import 'package:survey_kit/src/controller/survey_controller.dart';
import 'package:survey_kit/src/navigator/task_navigator.dart';
import 'package:survey_kit/src/widget/survey_progress_configuration.dart';

// The `SurveyConfiguration` class is an `InheritedWidget` that provides configuration data for surveys.
// It allows sharing the configuration data across the widget tree.
class SurveyConfiguration extends InheritedWidget {
  const SurveyConfiguration({
    super.key,
    required this.surveyProgressConfiguration,
    required this.taskNavigator,
    required this.surveyController,
    required this.localizations,
    required this.padding,
    required super.child,
  });

  // The `surveyProgressConfiguration` property holds the configuration for survey progress indicators.
  final SurveyProgressConfiguration surveyProgressConfiguration;
  // The `taskNavigator` property represents the task navigator for navigating between survey steps.
  final TaskNavigator taskNavigator;
  // The `surveyController` property is the controller for managing the survey state.
  final SurveyController surveyController;
  // The `localizations` property is an optional map of localized strings for internationalization.
  final Map<String, String>? localizations;
  // The `padding` property represents the padding for the survey UI.
  final EdgeInsets padding;

  // The `of` method is a static method that allows accessing the nearest `SurveyConfiguration`
  // instance from the given `BuildContext`.
  // It uses the `dependOnInheritedWidgetOfExactType` method to retrieve the
  //`SurveyConfiguration` instance from the widget tree.
  // If no `SurveyConfiguration` instance is found, it throws an assertion error.
  static SurveyConfiguration of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<SurveyConfiguration>();
    assert(result != null, 'No SurveyConfiguration found in context');
    return result!;
  }

  // The `updateShouldNotify` method is overridden from the `InheritedWidget` class.
  // It compares the `surveyProgressConfiguration` property of the current and old `SurveyConfiguration` objects.
  // If the `surveyProgressConfiguration` property has changed, it indicates that the widget should be updated.
  @override
  bool updateShouldNotify(SurveyConfiguration oldWidget) =>
      surveyProgressConfiguration != oldWidget.surveyProgressConfiguration;
}
