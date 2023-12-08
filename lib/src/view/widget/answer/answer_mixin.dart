import 'package:flutter/material.dart';
import 'package:survey_kit/src/view/widget/question_answer.dart';

/// This code defines a mixin called `AnswerMixin` in the `answer_mixin.dart` file.
/// The mixin is intended to be used with a StatefulWidget and provides functionality related to
/// handling answers in a survey question.
mixin AnswerMixin<T extends StatefulWidget, R> on State<T> {
  // This method is called when the answer changes.
  // It updates the validation status and the step result.
  void onChange(R? result) {
    onValidationChanged = isValid(result);
    onStepResultChanged = result;
  }

  // This method should be implemented by the classes using the mixin to define the validation logic.
  bool isValid(R? result);

  // Setter for updating the validation status.
  set onValidationChanged(bool isValid) {
    // Set the validation status in the QuestionAnswer widget using the context.
    QuestionAnswer.of(context).setIsValid(isValid);
  }

  // Setter for updating the step result.
  set onStepResultChanged(R? stepResult) {
    // Set the step result in the QuestionAnswer widget using the context.
    QuestionAnswer.of(context).setStepResult(stepResult);
  }
}
