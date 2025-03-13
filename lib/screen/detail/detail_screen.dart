import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../data/common/common.dart';
import '../../screen/detail/detail_error_state_widget.dart';
import '../../screen/detail/body_of_detail_widget.dart';
import '../../provider/story_detail_provider.dart';
import '../../static/story_detail_result_state.dart';

class DetailScreen extends StatefulWidget {
  final String storyId;

  const DetailScreen({super.key, required this.storyId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  void _fetchStoryDetail() {
    Future.microtask(() {
      Provider.of<StoryDetailProvider>(
        context,
        listen: false,
      ).fetchStoryDetail(widget.storyId);
    });
  }

  @override
  void initState() {
    super.initState();

    _fetchStoryDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Story Detail"), centerTitle: true),
      body: Consumer<StoryDetailProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            StoryDetailLoadingState() => Center(
              child: LoadingAnimationWidget.waveDots(
                color: Colors.blue,
                size: 50,
              ),
            ),
            StoryDetailLoadedState(data: var story) => BodyOfDetailWidget(
              story: story,
            ),
            StoryDetailErrorState(error: var message) => DetailErrorState(
              errorMessage: message,
              onRetry: _fetchStoryDetail,
            ),
            _ => Center(child: Text(AppLocalizations.of(context)!.loadingData)),
          };
        },
      ),
    );
  }
}
