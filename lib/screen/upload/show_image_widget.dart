import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/home_provider.dart';

class ShowImageWidget extends StatelessWidget {
  const ShowImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final imagePath = context.read<HomeProvider>().imagePath;
    return InteractiveViewer(
      boundaryMargin: EdgeInsets.all(20),
      minScale: 1.0,
      maxScale: 5.0,
      child:
          kIsWeb
              ? CachedNetworkImage(
                imageUrl: imagePath.toString(),
                height: 500,
                width: double.infinity,
                progressIndicatorBuilder:
                    (context, url, progress) => Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    ),
                errorWidget:
                    (context, url, error) => const Icon(Icons.error, size: 50),
              )
              : Image.file(
                File(imagePath.toString()),
                height: 500,
                fit: BoxFit.contain,
              ),
    );
  }
}
