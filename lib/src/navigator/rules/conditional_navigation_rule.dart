import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/navigator/rules/navigation_rule.dart';

// The `ConditionalNavigationRule` class implements the `NavigationRule` interface
//  and represents a conditional navigation rule.
// It allows defining a mapping function `resultToStepIdentifierMapper` that maps
// a list of `StepResult` and an input `StepResult` to a step identifier.

class ConditionalNavigationRule implements NavigationRule {
  // The `resultToStepIdentifierMapper` is a function that maps the results and input to a step identifier.
  final String? Function(List<StepResult>, StepResult?)
      resultToStepIdentifierMapper;

  // The constructor takes in a required parameter `resultToStepIdentifierMapper`,
  // which is a function that maps the results and input to a step identifier.
  ConditionalNavigationRule({required this.resultToStepIdentifierMapper});

  // The `fromJson` factory method creates a `ConditionalNavigationRule` object from a JSON map.
  // It retrieves the `values` property from the JSON map, which represents the mapping values.
  // It constructs a `ConditionalNavigationRule` object with the `resultToStepIdentifierMapper`
  //function that checks the input against the mapping values and returns the corresponding step identifier.
  factory ConditionalNavigationRule.fromJson(Map<String, dynamic> json) {
    final inputValues = json['values'] as Map<String, dynamic>;
    return ConditionalNavigationRule(
      resultToStepIdentifierMapper: (results, input) {
        for (final MapEntry entry in inputValues.entries) {
          if (entry.key == input) {
            return entry.value as String;
          }
        }
        return null;
      },
    );
  }

  // The `toJson` method converts the `ConditionalNavigationRule` object to a JSON map.
  // It returns an empty map for the `values` property, as the mapping values are not included in the JSON representation.
  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'values': <String, dynamic>{},
      };
}
