import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../data/common/common.dart';
import '../../data/model/story/story.dart';

class BodyOfDetailWidget extends StatelessWidget {
  final Story story;

  const BodyOfDetailWidget({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Hero(
                  tag: story.photoUrl,
                  child: _buildImage(story.photoUrl),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Center(
              child: Text(
                story.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Center(
              child: Text(
                AppLocalizations.of(
                  context,
                )!.postedOn(_formatDate(story.createdAt)),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[600],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.descriptionTitle,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                ),
                const SizedBox.square(dimension: 8),
                Text(
                  story.description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.5,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    if (imageUrl.endsWith('.svg')) {
      return SvgPicture.network(
        imageUrl,
        width: double.infinity,
        height: 400,
        placeholderBuilder:
            (context) => const Center(child: CircularProgressIndicator()),
      );
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        height: 400,
        width: double.infinity,
        progressIndicatorBuilder:
            (context, url, progress) => Center(
              child: CircularProgressIndicator(value: progress.progress),
            ),
        errorWidget: (context, url, error) => const Icon(Icons.error, size: 50),
      );
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
