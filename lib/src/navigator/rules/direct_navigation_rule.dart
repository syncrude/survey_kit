// The `DirectNavigationRule` class implements the `NavigationRule` interface and represents a direct navigation rule.
// It allows navigating to a specific destination step identified by `destinationStepIdentifier`.

import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/navigator/rules/navigation_rule.dart';

part 'direct_navigation_rule.g.dart';

@JsonSerializable()
class DirectNavigationRule implements NavigationRule {
  // The `destinationStepIdentifier` property represents the identifier of the destination step.
  final String destinationStepIdentifier;

  // The constructor takes in a required parameter `destinationStepIdentifier` and assigns it to the corresponding property.
  DirectNavigationRule(this.destinationStepIdentifier);

  // The `fromJson` factory method creates a `DirectNavigationRule` object from a JSON map.
  // It uses the generated `_$DirectNavigationRuleFromJson` function to deserialize the JSON map.
  factory DirectNavigationRule.fromJson(Map<String, dynamic> json) =>
      _$DirectNavigationRuleFromJson(json);

  // The `toJson` method converts the `DirectNavigationRule` object to a JSON map.
  // It uses the generated `_$DirectNavigationRuleToJson` function to serialize the object to JSON.
  @override
  Map<String, dynamic> toJson() => _$DirectNavigationRuleToJson(this);
}
