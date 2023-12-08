import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/task/navigable_task.dart';
import 'package:survey_kit/src/task/ordered_task.dart';
import 'package:survey_kit/src/task/task_not_defined_exception.dart';
import 'package:uuid/uuid.dart';

/// Abstract definition of survey task
///
/// If you want to create a custom task:
///  * Inherit from Task
///  * If you want to use JSON override [fromJson] and add your type
@immutable
abstract class Task {
  late final String id;
  @JsonKey(defaultValue: <Step>[])
  final List<Step> steps;
  final Step? initalStep;

  Task({
    String? id,
    this.steps = const [],
    this.initalStep,
  }) : id = id ?? const Uuid().v4();

  /// Creates a task from a Map. The task needs to have a type definition of
  /// either 'ordered' - [OrderedTask] or 'navigable' - [NavigableTask].
  /// If not it will throw a [TaskNotDefinedException].
  factory Task.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    if (type == 'ordered') {
      return OrderedTask.fromJson(json);
    } else if (type == 'navigable') {
      return NavigableTask.fromJson(json);
    }
    throw const TaskNotDefinedException();
  }
  // The `toJson` method converts the Task object to a JSON map.
  Map<String, dynamic> toJson();

  // The `operator ==` method overrides the equality operator for the Task class.
  // It compares the `id` and `steps` properties of two Task objects.
  // Two Task objects are considered equal if their `id` and `steps` properties are equal.
  @override
  bool operator ==(Object other) => other is Task && other.id == id;
  // The `hashCode` getter overrides the default `hashCode` getter for the `Task` class.
  // It calculates a hash code based on the `id` and `steps` properties of the `Task` object.
  @override
  int get hashCode => id.hashCode ^ steps.hashCode;
}
