import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/boolean_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_question_text.dart';
import 'package:survey_kit/src/view/widget/answer/selection_list_tile.dart';

/// This widget is responsible for displaying and handling the user's input for a boolean-based survey question.
class BooleanAnswerView extends StatefulWidget {
  final Step questionStep;
  final StepResult? result;

  const BooleanAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _BooleanAnswerViewState createState() => _BooleanAnswerViewState();
}

class _BooleanAnswerViewState extends State<BooleanAnswerView>
    with
        MeasureDateStateMixin<BooleanAnswerView>,
        AnswerMixin<BooleanAnswerView, BooleanResult> {
  late final BooleanAnswerFormat _answerFormat;
  BooleanResult? _result;

  @override
  void initState() {
    super.initState();
    final answer = widget.questionStep.answerFormat;
    if (answer == null) {
      throw Exception('BooleanAnswerFormat is null');
    }
    _answerFormat = answer as BooleanAnswerFormat;
    _result = widget.result?.result as BooleanResult? ?? _answerFormat.result;
  }

  @override
  bool isValid(dynamic result) {
    if (widget.questionStep.isMandatory) {
      return _result != null;
    }
    return true;
  }

  // This is the method that is called when the user selects an option.
  @override
  void onChange(BooleanResult? booleanResult) {
    // If the `booleanResult` is equal to the current `_result`, set `_result` to `null` to deselect the option.
    // Otherwise, set `_result` to the selected `booleanResult`.
    if (booleanResult == _result) {
      _result = null;
    } else {
      _result = booleanResult;
    }
    // Trigger a rebuild of the widget by calling `setState`.
    setState(() {});
    // Call the `onChange` method of the `AnswerMixin` superclass to update the validation status and step result.
    super.onChange(_result);
  }

  @override
  Widget build(BuildContext context) {
    // Get the question text from the answer format.
    final questionText = widget.questionStep.answerFormat?.question;
    return Column(
      children: [
        // If questionText is not null, display the question text using the `AnswerQuestionText` widget.
        if (questionText != null) AnswerQuestionText(text: questionText),
        const Divider(
          color: Colors.grey,
        ),
        SelectionListTile(
          text: _answerFormat.positiveAnswer,
          onTap: () => onChange(BooleanResult.positive),
          isSelected: _result == BooleanResult.positive,
        ),
        SelectionListTile(
          text: _answerFormat.negativeAnswer,
          onTap: () => onChange(BooleanResult.negative),
          isSelected: _result == BooleanResult.negative,
        ),
      ],
    );
  }
}
