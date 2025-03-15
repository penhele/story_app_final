import 'package:freezed_annotation/freezed_annotation.dart';

import 'story.dart';

part 'story_detail_response.g.dart';

part 'story_detail_response.freezed.dart';

@freezed
class StoryDetailResponse with _$StoryDetailResponse {
  const factory StoryDetailResponse({
    required bool error,
    required String message,
    @JsonKey(name: "story") required Story story,
  }) = _StoryDetailResponse;

  factory StoryDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryDetailResponseFromJson(json);
}
