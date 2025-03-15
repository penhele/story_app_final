import 'package:freezed_annotation/freezed_annotation.dart';

import 'story.dart';

part 'story_list_response.g.dart';

part 'story_list_response.freezed.dart';

@freezed
class StoryListResponse with _$StoryListResponse {
  const factory StoryListResponse({
    required bool error,
    required String message,
    @JsonKey(name: "listStory") required List<Story> stories,
  }) = _StoryListResponse;

  factory StoryListResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryListResponseFromJson(json);
}
