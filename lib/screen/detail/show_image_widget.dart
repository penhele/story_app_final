import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Showimagewidget extends StatelessWidget {
  final String imageUrl;

  const Showimagewidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl.endsWith('.svg')) {
      return SvgPicture.network(
        imageUrl,
        width: double.infinity,
        height: 400,
        placeholderBuilder:
            (context) => const Center(child: CircularProgressIndicator()),
      );
    } else {
      return InteractiveViewer(
        boundaryMargin: EdgeInsets.all(20),
        minScale: 1.0,
        maxScale: 5.0,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          height: 500,
          width: double.infinity,
          progressIndicatorBuilder:
              (context, url, progress) => Center(
                child: CircularProgressIndicator(value: progress.progress),
              ),
          errorWidget:
              (context, url, error) => const Icon(Icons.error, size: 50),
        ),
      );
    }
  }
}
