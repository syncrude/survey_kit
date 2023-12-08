import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';
import 'package:survey_kit/src/model/content/content.dart';
import 'package:survey_kit/src/survey_kit.dart';
import 'package:uuid/uuid.dart';

part 'step.g.dart';

/// This is the model class which represents a survey step.
@JsonSerializable()
class Step {
  final String id; // this is the unique identifier of the step
  final bool isMandatory; // this indicates if the step is mandatory
  final AnswerFormat? answerFormat; // this is the answer format of the step
  // This is the text of the button which is displayed on the bottom of the step (or 'Next' if not set)
  @JsonKey(defaultValue: 'Next', includeIfNull: false)
  final String? buttonText;
  // All the content which is displayed on the step
  final List<Content> content;
  // This is the shell of the step which is used to display the step
  @JsonKey(includeFromJson: false, includeToJson: false)
  final StepShell? stepShell;

  Step({
    String? id,
    required this.content,
    this.isMandatory = true,
    this.answerFormat,
    this.buttonText,
    this.stepShell,
  }) : id = id ?? const Uuid().v4();

  factory Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);

  Map<String, dynamic> toJson() => _$StepToJson(this);
}
