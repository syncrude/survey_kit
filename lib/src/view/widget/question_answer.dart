import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/survey_kit.dart';

/// This widget is the dynamic type to ensure a manadatory question is valid to continue the survey.
// ignore: must_be_immutable
class QuestionAnswer<R> extends InheritedWidget {
  QuestionAnswer({
    super.key,
    required super.child,
    required this.step,
  });

  DateTime startTime = DateTime.now();

  final Step step;

  final ValueNotifier<bool> isValid = ValueNotifier<bool>(true);
  // ignore: avoid_positional_boolean_parameters, use_setters_to_change_properties
  void setIsValid(bool isValid) {
    this.isValid.value = isValid;
  }

  StepResult<R?>? _stepResult; // define the type of the result
  StepResult<R?>? get stepResult => _stepResult; // get the result
  // set the result
  void setStepResult(R? result) {
    _stepResult = StepResult<R>(
      id: step.id,
      step: step,
      result: result,
      startTime: startTime,
      endTime: DateTime.now(),
    );
  }

  // make sure the QuestionAnswer is available in the context and return it or throw an error
  static QuestionAnswer of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<QuestionAnswer>();
    assert(result != null, 'No QuestionAnswer found in context');
    return result!;
  }

  // It determines whether the widget should notify its descendants when an update occurs.
  // If any of the compared properties (step, isValid, stepResult) are different between the current and previous widgets,
  //it indicates that an update has occurred and the method returns true.
  @override
  bool updateShouldNotify(QuestionAnswer oldWidget) {
    return oldWidget.step != step ||
        oldWidget.isValid != isValid ||
        oldWidget.stepResult != stepResult;
  }
}
