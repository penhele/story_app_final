import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../data/common/common.dart';
import '../../data/model/story/story.dart';

class BodyOfDetailWidget extends StatefulWidget {
  final Story story;

  const BodyOfDetailWidget({super.key, required this.story});

  @override
  State<BodyOfDetailWidget> createState() => _BodyOfDetailWidgetState();
}

class _BodyOfDetailWidgetState extends State<BodyOfDetailWidget> {
  GoogleMapController? mapController;
  final Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();

    if (widget.story.lat != null && widget.story.lon != null) {
      final storyLocation = LatLng(widget.story.lat!, widget.story.lon!);

      final marker = Marker(
        markerId: const MarkerId("story_location"),
        position: storyLocation,
        onTap: () {
          if (mapController != null) {
            mapController!.animateCamera(
              CameraUpdate.newLatLngZoom(storyLocation, 18),
            );
          }
        },
      );
      markers.add(marker);
    }
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool hasLocation = widget.story.lat != null && widget.story.lon != null;

    if (hasLocation) {
      return _withMap();
    } else {
      return _withoutMap();
    }
  }

  Widget _withMap() {
    return Center(
      child: Stack(
        children: [
          GoogleMap(
            markers: markers,
            initialCameraPosition: CameraPosition(
              zoom: 18,
              target: LatLng(widget.story.lat! - 0.0005, widget.story.lon!),
            ),
            onMapCreated: (controller) {
              if (mounted) {
                setState(() {
                  mapController = controller;
                });
              }
            },
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      FloatingActionButton.small(
                        heroTag: "zoom-in",
                        onPressed: () {
                          mapController?.animateCamera(CameraUpdate.zoomIn());
                        },
                        child: const Icon(Icons.add),
                      ),
                      FloatingActionButton.small(
                        heroTag: "zoom-out",
                        onPressed: () {
                          mapController?.animateCamera(CameraUpdate.zoomOut());
                        },
                        child: const Icon(Icons.remove),
                      ),
                    ],
                  ),

                  SizedBox.square(dimension: 8),

                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffEBE8DB),
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                widget.story.name,
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff143D60),
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            Center(
                              child: Text(
                                AppLocalizations.of(context)!.postedOn(
                                  _formatDate(widget.story.createdAt),
                                ),
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            Text(
                              widget.story.description,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.copyWith(
                                height: 1.5,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _withoutMap() {
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
                  tag: widget.story.photoUrl,
                  child: _buildImage(widget.story.photoUrl),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Center(
              child: Text(
                widget.story.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff143D60),
                ),
              ),
            ),

            const SizedBox(height: 8),

            Center(
              child: Text(
                AppLocalizations.of(
                  context,
                )!.postedOn(_formatDate(widget.story.createdAt)),
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
                  widget.story.description,
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
