import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import '../model/story/add_story_request.dart';
import '../model/story/add_story_response.dart';
import '../model/story/story_detail_response.dart';
import '../model/story/story_list_response.dart';

class ApiService {
  static const String _baseUrl = "https://story-api.dicoding.dev/v1";

  Future<StoryListResponse> getStories(String token) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/stories"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      return StoryListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load story list");
    }
  }

  Future<StoryDetailResponse> getStoryDetail(String token, String id) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/stories/$id"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      return StoryDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load story detail");
    }
  }

  Future<AddStoryResponse> addStory(
    AddStoryRequest addStoryData,
    String token,
  ) async {
    var uri = Uri.parse("$_baseUrl/stories");

    var request =
        http.MultipartRequest("POST", uri)
          ..headers["Authorization"] = "Bearer $token"
          ..fields["description"] = addStoryData.description;

    if (addStoryData.lat != null) {
      request.fields["lat"] = addStoryData.lat.toString();
    }
    if (addStoryData.lon != null) {
      request.fields["lon"] = addStoryData.lon.toString();
    }

    String? mimeType = lookupMimeType(addStoryData.photo.path) ?? 'image/jpeg';

    if (kIsWeb) {
      final bytes = await addStoryData.photo.readAsBytes();
      request.files.add(http.MultipartFile.fromBytes(
        "photo",
        bytes,
        filename: addStoryData.photo.name,
        contentType: MediaType.parse(mimeType),
      ));
    } else {
      request.files.add(await http.MultipartFile.fromPath(
        "photo",
        addStoryData.photo.path,
        contentType: MediaType.parse(mimeType),
      ));
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      return AddStoryResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to add story: ${response.body}");
    }
  }
}
