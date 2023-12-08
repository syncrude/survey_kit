import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

// Including the generated part file 'time_result.g.dart' that contains the JSON serialization and deserialization code.
part 'time_result.g.dart';

// Annotating the class as immutable, meaning its properties cannot be changed after instantiation.
// Applying a custom TimeOfDay converter for JSON serialization and deserialization.
@JsonSerializable()
class TimeResult {
  @_TimeOfDayConverter()
  final TimeOfDay timeOfDay;

  const TimeResult({
    required this.timeOfDay,
  });
}

// A custom TimeOfDay converter that implements the JsonConverter interface.
class _TimeOfDayConverter extends JsonConverter<TimeOfDay, String?> {
  const _TimeOfDayConverter();

  // A method that converts JSON data to a TimeOfDay object.
  @override
  TimeOfDay fromJson(String? json) {
    if (json == null) {
      throw Exception('TimeOfDay cannot be null');
    }

    // A method that removes the leading zero from a string if it exists.
    String _removeLeadingZeroIfNeeded(String value) {
      if (value.startsWith('0')) {
        const indexOfSecondCharacter = 1;
        return value.substring(indexOfSecondCharacter);
      } else {
        return value;
      }
    }

    final elements = json.split(':'); // Split the string at the ':' character.
    final hourString = _removeLeadingZeroIfNeeded(
        elements.first); // Remove the leading zero from the first element.
    final minuteString = _removeLeadingZeroIfNeeded(
        elements.last); // Remove the leading zero from the last element.

    final hour =
        int.tryParse(hourString); // Convert the hour string to an integer.
    final minute =
        int.tryParse(minuteString); // Convert the minute string to an integer.

    // If the hour and minute are not null, return a TimeOfDay object with the hour and minute.
    if (hour != null && minute != null) {
      return TimeOfDay(hour: hour, minute: minute);
    }
    throw Exception('TimeOfDay cannot be parsed');
  }

  // A method that converts a TimeOfDay object to JSON data.
  @override
  String toJson(TimeOfDay object) {
    // A method that adds a leading zero to a string if the value is less than 10.
    String _addLeadingZeroIfNeeded(int value) {
      if (value < 10) {
        return '0$value';
      }
      return value.toString();
    }

    final hourLabel = _addLeadingZeroIfNeeded(object.hour);
    final minuteLabel = _addLeadingZeroIfNeeded(object.minute);

    // Return the hour and minute separated by a ':' character.
    return '$hourLabel:$minuteLabel';
  }
}
