import 'package:flutter/material.dart' hide Step;
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/datetime_convert.dart';

// Including the generated part file 'step_result.g.dart' that contains the JSON serialization and deserialization code.
part 'step_result.g.dart';

// Annotating the class as immutable, meaning its properties cannot be changed after instantiation.
// Applying a custom DateTime converter for JSON serialization and deserialization.
@immutable
@JsonSerializable(genericArgumentFactories: true)
@CustomDateTimeConverter()
class StepResult<T> {
  final String id; // The unique identifier for the step result.
  final Step step; // The step that was presented to the participant.
  final T? result; // The result of the step (optional)
  final DateTime startTime; // The time when the step started.
  final DateTime endTime; // The time when the step ended.
  // Specifying that the following property should be included in JSON only if it is not null.
  @JsonKey(includeIfNull: false)
  final String?
      valueIdentifier; // A value identifier for the step result (optional)

  const StepResult({
    required this.id,
    required this.result,
    required this.startTime,
    required this.endTime,
    required this.step,
    this.valueIdentifier,
  });

  // A factory constructor that creates a new StepResult object from a question result.
  factory StepResult.fromQuestion({required StepResult questionResult}) {
    return StepResult(
      id: questionResult.id,
      step: questionResult.step,
      startTime: questionResult.startTime,
      endTime: questionResult.endTime,
      result: questionResult as T?,
    );
  }

  // A factory constructor that creates a new StepResult object from a map of JSON data.
  factory StepResult.fromJson(Map<String, dynamic> json) =>
      _$StepResultFromJson(json, (json) => json as T);

  // A method that converts the StepResult object into a map of JSON data.
  Map<String, dynamic> toJson() => _$StepResultToJson(this, (result) => result);

  // Calculates the hash code for the StepResult object based on the hash codes of its id, startTime, and endTime properties.
  // The '^' operator is used to perform bitwise XOR operations on the hash codes.
  @override
  int get hashCode => id.hashCode ^ startTime.hashCode ^ endTime.hashCode;

  // Overrides the equality operator to compare if two StepResult objects are equal.
  // Two StepResult objects are considered equal if they have the same runtimeType, id, startTime, and endTime properties.
  // The 'identical' function checks if the two objects are the same instance in memory.
  // The 'is' keyword checks if the 'other' object is of type StepResult.
  // The 'runtimeType' property is used to compare the types of the objects.
  // The '==' operator is used to compare the id, startTime, and endTime properties of the objects.
  // If any of the conditions are met, the objects are considered equal.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is StepResult &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            startTime == other.startTime &&
            endTime == other.endTime;
  }
}
