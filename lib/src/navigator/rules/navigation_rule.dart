import 'package:survey_kit/src/navigator/rules/conditional_navigation_rule.dart';
import 'package:survey_kit/src/navigator/rules/direct_navigation_rule.dart';
import 'package:survey_kit/src/navigator/rules/rule_not_defined_exception.dart';

abstract class NavigationRule {
  const NavigationRule();

  // The factory method `fromJson` creates a `NavigationRule` object from a JSON map.
  // It checks the `type` property in the JSON map to determine the specific subclass of `NavigationRule` to instantiate.
  // If the `type` is 'conditional', it creates a `ConditionalNavigationRule` object using
  //  the `ConditionalNavigationRule.fromJson` factory method.
  // If the `type` is 'direct', it creates a `DirectNavigationRule` object using the
  //  `DirectNavigationRule.fromJson` factory method.
  // If the `type` is not defined or unrecognized, it throws a `RuleNotDefinedException`.
  factory NavigationRule.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    if (type == 'conditional') {
      return ConditionalNavigationRule.fromJson(json);
    } else if (type == 'direct') {
      return DirectNavigationRule.fromJson(json);
    }
    throw const RuleNotDefinedException();
  }

  // The `toJson` method is an abstract method that needs to be implemented by the subclasses of `NavigationRule`.
  // It converts the `NavigationRule` object to a JSON map.
  Map<String, dynamic> toJson();
}
