import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/util/datetime_convert.dart';

// Including the generated part file 'survey_result.g.dart' that contains the JSON serialization and deserialization code.
part 'survey_result.g.dart';

// Annotating the class as immutable, meaning its properties cannot be changed after instantiation.
// Applying a custom DateTime converter for JSON serialization and deserialization.
@immutable
@JsonSerializable(explicitToJson: true)
@CustomDateTimeConverter()
class SurveyResult {
  final String id; // The unique identifier for the survey result.
  final DateTime startTime; // The time when the survey started.
  final DateTime endTime; // The time when the survey ended.
  final FinishReason finishReason; // The reason why the survey ended.
  final List<StepResult> results; // The results of the survey.

  const SurveyResult({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.finishReason,
    required this.results,
  });

  // A factory constructor that creates a new SurveyResult object from a map of JSON data.
  factory SurveyResult.fromJson(Map<String, dynamic> json) =>
      _$SurveyResultFromJson(json);

  // A method that converts the SurveyResult object into a map of JSON data.
  Map<String, dynamic> toJson() => _$SurveyResultToJson(this);

  // Overrides the equality operator to compare if two SurveyResult objects are equal.
  // Two SurveyResult objects are considered equal if they have the same runtimeType, id, startTime, endTime, and finishReason properties.
  // The 'identical' function checks if the two objects are the same instance in memory.
  // The 'is' keyword checks if the 'other' object is of type SurveyResult.
  // The 'runtimeType' property is used to compare the types of the objects.
  // The '==' operator is used to compare the id, startTime, endTime, and finishReason properties of the objects.
  // If any of the conditions are met, the objects are considered equal.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurveyResult &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          finishReason == other.finishReason;

  // Calculates the hash code for the SurveyResult object based on the hash codes of its id, startTime, endTime, finishReason, and results properties.
  // The '^' operator is used to perform bitwise XOR operations on the hash codes.
  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      finishReason.hashCode ^
      results.hashCode;
}

enum FinishReason { saved, discarded, completed, failed }
