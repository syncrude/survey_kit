import 'package:json_annotation/json_annotation.dart';

// Including the generated part file 'video_result.g.dart' that contains the JSON serialization and deserialization code.
part 'video_result.g.dart';

// Applying a custom Duration converter for JSON serialization and deserialization.
@JsonSerializable()
class VideoResult {
  final Duration leftVideoAt; // The time when the video was left.
  final DateTime stayedInVideo; // The time when the video was started.

  const VideoResult({
    required this.leftVideoAt,
    required this.stayedInVideo,
  });

  factory VideoResult.fromJson(Map<String, dynamic> json) =>
      _$VideoResultFromJson(json);

  Map<String, dynamic> toJson() => _$VideoResultToJson(this);
}
