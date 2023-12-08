import 'package:json_annotation/json_annotation.dart';

// Define a custom converter class for DateTime to String conversion.
class CustomDateTimeConverter implements JsonConverter<DateTime, String> {
  const CustomDateTimeConverter();

  // Convert the JSON string to a DateTime object.
  @override
  DateTime fromJson(String json) {
    return DateTime.parse(json);
  }

  // Convert the DateTime object to a formatted ISO 8601 string.
  @override
  String toJson(DateTime json) {
    // Ignore microseconds and convert the DateTime to UTC.
    final date = DateTime(
      json.year,
      json.month,
      json.day,
      json.hour,
      json.minute,
      json.second,
      json.millisecond,
    ).toUtc();

    return date.toIso8601String();
  }
}
