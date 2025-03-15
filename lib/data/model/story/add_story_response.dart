import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_story_response.g.dart';

part 'add_story_response.freezed.dart';

@freezed
class AddStoryResponse with _$AddStoryResponse {
  const factory AddStoryResponse({
    required bool error,
    required String message,
  }) = _AddStoryResponse;

  factory AddStoryResponse.fromJson(Map<String, dynamic> json) =>
      _$AddStoryResponseFromJson(json);
}
