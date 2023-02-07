import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/single_choice_answer_format.dart';
import 'package:survey_kit/src/model/answer/text_choice.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/selection_list_tile.dart';

class SingleChoiceAnswerView extends StatefulWidget {
  final Step questionStep;
  final StepResult? result;

  const SingleChoiceAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _SingleChoiceAnswerViewState createState() => _SingleChoiceAnswerViewState();
}

class _SingleChoiceAnswerViewState extends State<SingleChoiceAnswerView>
    with MeasureDateStateMixin {
  late final SingleChoiceAnswerFormat _singleChoiceAnswerFormat;
  TextChoice? _selectedChoice;

  @override
  void initState() {
    super.initState();
    final answer = widget.questionStep.answerFormat;
    if (answer == null) {
      throw Exception('SingleSelectAnswer is null');
    }
    _singleChoiceAnswerFormat = answer as SingleChoiceAnswerFormat;
    _selectedChoice = widget.result?.result as TextChoice? ??
        _singleChoiceAnswerFormat.defaultSelection;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        children: [
          const Divider(
            color: Colors.grey,
          ),
          ..._singleChoiceAnswerFormat.textChoices.map(
            (TextChoice tc) {
              return SelectionListTile(
                text: tc.value,
                onTap: () {
                  if (_selectedChoice == tc) {
                    _selectedChoice = null;
                  } else {
                    _selectedChoice = tc;
                  }
                  setState(() {});
                },
                isSelected: _selectedChoice == tc,
              );
            },
          ).toList(),
        ],
      ),
    );
  }
}
