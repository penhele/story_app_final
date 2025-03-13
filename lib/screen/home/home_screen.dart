import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../screen/home/flag_icon_widget.dart';
import '../../data/common/common.dart';
import '../../screen/home/home_error_state_widget.dart';
import '../../provider/home_provider.dart';
import '../../screen/home/story_list_widget.dart';
import '../../provider/auth_provider.dart';
import '../../provider/story_list_provider.dart';
import '../../static/story_list_result_state.dart';

class HomeScreen extends StatefulWidget {
  final Function(String) onTapped;
  final Function() onLogout;
  final Function() toAddStoryScreen;

  const HomeScreen({
    super.key,
    required this.onTapped,
    required this.onLogout,
    required this.toAddStoryScreen,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();

  void _fetchStoryList() {
    Future.microtask(() {
      Provider.of<StoryListProvider>(context, listen: false).fetchStoryList();
    });
  }

  @override
  void initState() {
    super.initState();

    final storyListProvider = context.read<StoryListProvider>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (storyListProvider.pageItems != null) {
          storyListProvider.fetchStoryList();
        }
      }
    });

    _fetchStoryList();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Story App"),
        centerTitle: true,
        actions: [
          const FlagIconWidget(),
          const SizedBox.square(dimension: 8),
          IconButton(
            onPressed: () async {
              final authRead = context.read<AuthProvider>();
              final result = await authRead.logout();
              if (result) widget.onLogout();
            },
            icon: Icon(Icons.logout),
            tooltip: AppLocalizations.of(context)!.logoutTooltip,
          ),
        ],
      ),
      body: Consumer<StoryListProvider>(
        builder: (context, value, child) {
          if (value.resultState is StoryListLoadingState &&
              value.pageItems == 1) {
            return Center(
              child: LoadingAnimationWidget.waveDots(
                color: Colors.blue,
                size: 50,
              ),
            );
          } else if (value.resultState is StoryListLoadedState) {
            final storyList = value.stories;

            return ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.only(bottom: 18),
              itemCount: storyList.length + (value.pageItems != null ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == storyList.length && value.pageItems != null) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: LoadingAnimationWidget.waveDots(
                        color: Colors.blue,
                        size: 50,
                      ),
                    ),
                  );
                }

                final story = storyList[index];

                return StoryListWidget(
                  story: story,
                  onTap: () => widget.onTapped(story.id),
                );
              },
            );
          } else if (value.resultState is StoryListErrorState) {
            final message = (value.resultState as StoryListErrorState).error;
            return Center(
              child: HomeErrorState(
                errorMessage: message,
                onRetry: _fetchStoryList,
              ),
            );
          } else {
            return Center(
              child: Text(AppLocalizations.of(context)!.loadingData),
            );
          }
        },
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        children: [
          SpeedDialChild(
            child: Icon(Icons.camera),
            label: AppLocalizations.of(context)!.cameraLabel,
            onTap: () => _onCameraView(),
          ),
          SpeedDialChild(
            child: Icon(Icons.photo),
            label: AppLocalizations.of(context)!.galleryLabel,
            onTap: () => _onGalleryView(),
          ),
        ],
      ),
    );
  }

  _onGalleryView() async {
    final provider = context.read<HomeProvider>();

    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;
    if (isMacOS || isLinux) return;

    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);

      widget.toAddStoryScreen();
    }
  }

  _onCameraView() async {
    final provider = context.read<HomeProvider>();

    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;

    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);

      widget.toAddStoryScreen();
    }
  }
}
