class AddStoryResponse {
  bool error;
  String message;

  AddStoryResponse({required this.error, required this.message});

  factory AddStoryResponse.fromJson(Map<String, dynamic> json) =>
      AddStoryResponse(error: json["error"], message: json["message"]);
}
