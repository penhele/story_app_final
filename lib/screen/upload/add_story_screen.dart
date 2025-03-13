import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../data/common/common.dart';
import '../../provider/story_list_provider.dart';
import '../../data/model/story/add_story_request.dart';
import '../../provider/add_story_provider.dart';
import '../../provider/home_provider.dart';

class AddStoryScreen extends StatefulWidget {
  final Function() toHomeScreen;

  const AddStoryScreen({super.key, required this.toHomeScreen});

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final addStoryProvider = context.watch<AddStoryProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addStoryAppBar),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              homeProvider.imagePath == null
                  ? const Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.image, size: 100),
                  )
                  : _showImage(context),

              const SizedBox(height: 16.0),

              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.descriptionHint,
                  labelText: AppLocalizations.of(context)!.descriptionLabel,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                maxLines: 3,
              ),

              const SizedBox(height: 16.0),

              addStoryProvider.isAddStoryLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () async => await _uploadStory(context),
                      icon: const Icon(Icons.cloud_upload, color: Colors.white),
                      label: Text(
                        AppLocalizations.of(context)!.uploadLabel,
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff4F959D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),

              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showImage(BuildContext context) {
    final imagePath = context.read<HomeProvider>().imagePath;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child:
              kIsWeb
                  ? Image.network(
                    imagePath.toString(),
                    height: 500,
                    fit: BoxFit.contain,
                  )
                  : Image.file(
                    File(imagePath.toString()),
                    height: 500,
                    fit: BoxFit.contain,
                  ),
        ),
      ],
    );
  }

  Future<void> _uploadStory(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final homeProvider = context.read<HomeProvider>();
    final addStoryProvider = context.read<AddStoryProvider>();

    final XFile? imageFile = homeProvider.imageFile;
    if (imageFile == null) {
      scaffoldMessenger.showSnackBar(
        _buildSnackBar(
          AppLocalizations.of(context)!.errorSelectImage,
          Colors.red,
        ),
      );
      return;
    }

    if (!kIsWeb) {
      File file = File(imageFile.path);
      int fileSize = await file.length();
      if (fileSize > 1024 * 1024) {
        scaffoldMessenger.showSnackBar(
          _buildSnackBar(
            AppLocalizations.of(context)!.errorFileTooLarge,
            Colors.orange,
          ),
        );
        return;
      }
    }

    if (descriptionController.text.trim().isEmpty) {
      scaffoldMessenger.showSnackBar(
        _buildSnackBar(
          AppLocalizations.of(context)!.errorEmptyDescription,
          Colors.red,
        ),
      );
      return;
    }

    final AddStoryRequest addStory = AddStoryRequest(
      description: descriptionController.text,
      photo: imageFile,
      lat: null,
      lon: null,
    );

    try {
      final result = await addStoryProvider.addStory(addStory);
      if (result) {
        context.read<StoryListProvider>().fetchStoryList();
        widget.toHomeScreen();
      } else {
        scaffoldMessenger.showSnackBar(
          _buildSnackBar(
            AppLocalizations.of(context)!.errorUploadFailed,
            Colors.red,
          ),
        );
      }
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        _buildSnackBar(
          AppLocalizations.of(context)!.errorUnexpected("{err}"),
          Colors.red,
        ),
      );
    }
  }

  SnackBar _buildSnackBar(String message, Color color) {
    return SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
    );
  }
}
