import 'package:flutter/material.dart';
import 'package:story_app_final/data/model/story/story.dart';
import '../data/api/api_service.dart';
import '../provider/auth_provider.dart';
import '../static/story_list_result_state.dart';

class StoryListProvider extends ChangeNotifier {
  final ApiService _apiService;
  final AuthProvider _authProvider;

  StoryListProvider(this._apiService, this._authProvider);

  StoryListResultState _resultState = StoryListNoneState();

  StoryListResultState get resultState => _resultState;

  int? pageItems = 1;
  int sizeItems = 10;

  List<Story> stories = [];

  Future<void> fetchStoryList() async {
    try {
      if (pageItems == 1) {
        _resultState = StoryListLoadingState();
        notifyListeners();
      }

      final token = _authProvider.token;

      if (token == null) {
        _resultState = StoryListErrorState("Token tidak tersedia");
        notifyListeners();
        return;
      }

      final result = await _apiService.getStories(token, pageItems!, sizeItems);

      stories.addAll(result.stories);

      if (result.error) {
        _resultState = StoryListErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = StoryListLoadedState(result.stories);

        if (result.stories.length < sizeItems) {
          pageItems = null;
        } else {
          pageItems = pageItems! + 1;
        }

        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = StoryListErrorState(e.toString());
      notifyListeners();
    }
  }

  Future<void> refreshStoryList() async {
    pageItems = 1;
    stories = [];
    notifyListeners();

    fetchStoryList();
  }
}
