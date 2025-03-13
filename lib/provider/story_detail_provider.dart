import 'package:flutter/material.dart';
import 'auth_provider.dart';
import '../static/story_detail_result_state.dart';
import '../data/api/api_service.dart';

class StoryDetailProvider extends ChangeNotifier {
  final ApiService _apiService;
  final AuthProvider _authProvider;

  StoryDetailProvider(this._apiService, this._authProvider);

  StoryDetailResultState _resultState = StoryDetailNoneState();

  StoryDetailResultState get resultState => _resultState;

  Future<void> fetchStoryDetail(String id) async {
    try {
      _resultState = StoryDetailLoadingState();
      notifyListeners();

      final token = _authProvider.token;

      if (token == null) {
        _resultState = StoryDetailErrorState("Token tidak tersedia");
        notifyListeners();
        return;
      }

      final result = await _apiService.getStoryDetail(token, id);

      if (result.error) {
        _resultState = StoryDetailErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = StoryDetailLoadedState(result.story);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = StoryDetailErrorState(e.toString());
      notifyListeners();
    }
  }
}
