// Import the necessary packages for Flutter UI, state management, and survey functionality.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/presenter/survey_state_provider.dart';

// Define a mixin called `PreviousStepResultMixin` that extends `State<T>`.
// This mixin is intended to be used with a `StatefulWidget` to provide functionality
// for retrieving the result of a previous step in a survey.
mixin PreviousStepResultMixin<T extends StatefulWidget> on State<T> {
  // Define a method called `stepResultById` that takes an `id` of type `String` as input and returns a `StepResult` object.
  // This method retrieves the step result with the specified `id` from the `SurveyStateProvider`.
  StepResult? stepResultById(String id) {
    // Access the `SurveyStateProvider` using the `Provider.of` method.
    final surveyPresenter =
        Provider.of<SurveyStateProvider>(context, listen: false);
    // Retrieve the step result by calling the `getStepResultById` method on the `SurveyStateProvider`.
    return surveyPresenter.getStepResultById(id);
  }
}
