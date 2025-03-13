import 'story.dart';

class StoryListResponse {
  bool error;
  String message;
  List<Story> stories;

  StoryListResponse({
    required this.error,
    required this.message,
    required this.stories,
  });

  factory StoryListResponse.fromJson(Map<String, dynamic> json) =>
      StoryListResponse(
        error: json["error"],
        message: json["message"],
        stories: List<Story>.from(
          json["listStory"].map((x) => Story.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "listStory": List<dynamic>.from(stories.map((x) => x.toJson())),
  };
}
